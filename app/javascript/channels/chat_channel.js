import consumer from "./consumer";

const initChatCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatId;

    consumer.subscriptions.create({ channel: "ChatChannel", id: id }, {
      received(data) {
        messagesContainer.insertAdjacentHTML('beforeend', data);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
      },
    });
  }
}

export { initChatCable };
