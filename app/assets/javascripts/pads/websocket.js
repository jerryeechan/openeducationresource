dispatcher = new WebSocketRails('localhost:3000/websocket');
dispatcher.bind('test_message', function(data) {
      console.log(data.message); // would output 'this is a message'
});
