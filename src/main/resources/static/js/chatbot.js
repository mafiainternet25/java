// Chatbot JavaScript
(function() {
    'use strict';

    class Chatbot {
        constructor() {
            this.isOpen = false;
            this.messages = [];
            this.init();
        }

        init() {
            this.createWidget();
            this.loadMessages();
            this.attachEvents();
        }

        createWidget() {
            const container = document.createElement('div');
            container.className = 'chatbot-container';
            container.innerHTML = `
                <div class="chatbot-window" id="chatbotWindow">
                    <div class="chatbot-header">
                        <div>
                            <h3>
                                <i class="fas fa-robot"></i>
                                Trợ lý QUOCSHOP
                            </h3>
                            <div class="status">
                                <span class="status-dot"></span>
                                <span>Đang hoạt động</span>
                            </div>
                        </div>
                        <button class="close-btn" id="chatbotClose">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="chatbot-messages" id="chatbotMessages">
                        <div class="message bot">
                            <div>Xin chào! 👋 Tôi là trợ lý ảo của QUOCSHOP. Tôi có thể giúp bạn tìm sản phẩm, hướng dẫn sử dụng website và trả lời các câu hỏi. Bạn cần hỗ trợ gì?</div>
                            <div class="timestamp">${this.getCurrentTime()}</div>
                        </div>
                    </div>
                    <div class="quick-suggestions" id="quickSuggestions">
                        <button class="suggestion-btn" data-message="Tìm áo thun">Tìm áo thun</button>
                        <button class="suggestion-btn" data-message="Hướng dẫn đặt hàng">Hướng dẫn đặt hàng</button>
                        <button class="suggestion-btn" data-message="Chính sách giao hàng">Chính sách giao hàng</button>
                    </div>
                    <div class="chatbot-input-container">
                        <input type="text" class="chatbot-input" id="chatbotInput" 
                               placeholder="Nhập câu hỏi của bạn..." />
                        <button class="chatbot-send-btn" id="chatbotSend">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
                <button class="chatbot-button" id="chatbotButton">
                    <i class="fas fa-comments"></i>
                </button>
            `;
            document.body.appendChild(container);
        }

        attachEvents() {
            const button = document.getElementById('chatbotButton');
            const closeBtn = document.getElementById('chatbotClose');
            const sendBtn = document.getElementById('chatbotSend');
            const input = document.getElementById('chatbotInput');
            const window = document.getElementById('chatbotWindow');
            const suggestions = document.querySelectorAll('.suggestion-btn');

            button.addEventListener('click', () => this.toggle());
            closeBtn.addEventListener('click', () => this.close());
            sendBtn.addEventListener('click', () => this.sendMessage());
            
            input.addEventListener('keypress', (e) => {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    this.sendMessage();
                }
            });

            suggestions.forEach(btn => {
                btn.addEventListener('click', (e) => {
                    const message = e.target.getAttribute('data-message');
                    input.value = message;
                    this.sendMessage();
                });
            });

            // Click outside to close
            window.addEventListener('click', (e) => {
                if (e.target === window) {
                    this.close();
                }
            });
        }

        toggle() {
            this.isOpen = !this.isOpen;
            const window = document.getElementById('chatbotWindow');
            if (this.isOpen) {
                window.classList.add('active');
                document.getElementById('chatbotInput').focus();
            } else {
                window.classList.remove('active');
            }
        }

        close() {
            this.isOpen = false;
            document.getElementById('chatbotWindow').classList.remove('active');
        }

        async sendMessage() {
            const input = document.getElementById('chatbotInput');
            const message = input.value.trim();
            
            if (!message) return;

            // Add user message
            this.addMessage(message, 'user');
            input.value = '';
            
            // Show typing indicator
            this.showTyping();
            
            try {
                const response = await fetch('/api/chatbot/message', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ message: message })
                });

                const data = await response.json();
                this.hideTyping();
                this.addMessage(data.response, 'bot');
            } catch (error) {
                this.hideTyping();
                this.addMessage('Xin lỗi, đã có lỗi xảy ra. Vui lòng thử lại sau.', 'bot');
                console.error('Chatbot error:', error);
            }
        }

        addMessage(text, type) {
            const messagesContainer = document.getElementById('chatbotMessages');
            const messageDiv = document.createElement('div');
            messageDiv.className = `message ${type}`;
            
            // Format message text (support line breaks)
            const formattedText = text.replace(/\n/g, '<br>');
            
            messageDiv.innerHTML = `
                <div>${formattedText}</div>
                <div class="timestamp">${this.getCurrentTime()}</div>
            `;
            
            messagesContainer.appendChild(messageDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
            
            // Save to local storage
            this.messages.push({ text, type, time: new Date() });
            this.saveMessages();
        }

        showTyping() {
            const messagesContainer = document.getElementById('chatbotMessages');
            const typingDiv = document.createElement('div');
            typingDiv.className = 'typing-indicator';
            typingDiv.id = 'typingIndicator';
            typingDiv.innerHTML = `
                <span></span>
                <span></span>
                <span></span>
            `;
            messagesContainer.appendChild(typingDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

        hideTyping() {
            const typing = document.getElementById('typingIndicator');
            if (typing) {
                typing.remove();
            }
        }

        getCurrentTime() {
            const now = new Date();
            return now.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' });
        }

        saveMessages() {
            try {
                localStorage.setItem('chatbot_messages', JSON.stringify(this.messages.slice(-50))); // Keep last 50 messages
            } catch (e) {
                console.error('Failed to save messages:', e);
            }
        }

        loadMessages() {
            try {
                const saved = localStorage.getItem('chatbot_messages');
                if (saved) {
                    this.messages = JSON.parse(saved);
                    // Optionally restore messages on load
                }
            } catch (e) {
                console.error('Failed to load messages:', e);
            }
        }
    }

    // Initialize chatbot when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            new Chatbot();
        });
    } else {
        new Chatbot();
    }
})();




