import 'package:flutter/material.dart';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({super.key});

  @override
  State<DiscussionPage> createState() => _DiscussionPageState();
}

class _DiscussionPage extends State<DiscussionPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'Discussion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DiscussionPage(), // Set DiscussionPage as the home screen
    );
  }
}

class Message {
  final String sender;
  final String content;
  final DateTime timestamp;
  int likes;
  int dislikes;
  bool isLiked;
  bool isDisliked;
  List<Message> replies;

  Message({
    required this.sender,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.dislikes = 0,
    this.isLiked = false,
    this.isDisliked = false,
    this.replies = const [],
  });
}

class _DiscussionPageState extends State<DiscussionPage> {
  bool isDarkMode = false; // Flag for dark mode
  List<Message> messages = [
    Message(
        sender: "Eyiniola Fagbemi",
        content: "Hello, this is a message.",
        timestamp: DateTime.now()),
    Message(
        sender: "Ismail Kewa",
        content: "This is another message.",
        timestamp: DateTime.now()),
    Message(
        sender: "Samuel Komaiya",
        content: "Sample content for a message.",
        timestamp: DateTime.now()),
  ];

  final TextEditingController messageController = TextEditingController();
  final TextEditingController replyController = TextEditingController();

  void addReply(int index, String replyContent) {
    setState(() {
      messages[index].replies = [
        ...messages[index].replies,
        Message(
            sender: "You", content: replyContent, timestamp: DateTime.now()),
      ];
    });
    replyController.clear();
  }

  void toggleLike(int index) {
    setState(() {
      if (messages[index].isLiked) {
        messages[index].likes -= 1;
      } else {
        messages[index].likes += 1;
        if (messages[index].isDisliked) {
          messages[index].dislikes -= 1;
          messages[index].isDisliked = false;
        }
      }
      messages[index].isLiked = !messages[index].isLiked;
    });
  }

  void toggleDislike(int index) {
    setState(() {
      if (messages[index].isDisliked) {
        messages[index].dislikes -= 1;
      } else {
        messages[index].dislikes += 1;
        if (messages[index].isLiked) {
          messages[index].likes -= 1;
          messages[index].isLiked = false;
        }
      }
      messages[index].isDisliked = !messages[index].isDisliked;
    });
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add(
          Message(
            sender: "You",
            content: messageController.text,
            timestamp: DateTime.now(),
          ),
        );
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title:
              const Text('Discussion', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            messages[index].sender,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4.0),
                          Text(messages[index].content),
                          const SizedBox(height: 4.0),
                          Text(
                            "${messages[index].timestamp.hour}:${messages[index].timestamp.minute} on ${messages[index].timestamp.day}-${messages[index].timestamp.month}-${messages[index].timestamp.year}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.thumb_up,
                                      color: messages[index].isLiked
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    onPressed: () => toggleLike(index),
                                  ),
                                  Text('${messages[index].likes}'),
                                  IconButton(
                                    icon: Icon(
                                      Icons.thumb_down,
                                      color: messages[index].isDisliked
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () => toggleDislike(index),
                                  ),
                                  Text('${messages[index].dislikes}'),
                                ],
                              ),
                              TextButton(
                                child: Text(
                                    "Replies (${messages[index].replies.length})"),
                                onPressed: () => _showReplies(context, index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReplies(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: messages[index].replies.length,
                      itemBuilder: (context, replyIndex) {
                        final reply = messages[index].replies[replyIndex];
                        return ListTile(
                          title: Text(reply.sender),
                          subtitle: Text(reply.content),
                          trailing: Text(
                            "${reply.timestamp.hour}:${reply.timestamp.minute}",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: replyController,
                            decoration: const InputDecoration(
                              hintText: 'Write a reply...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (replyController.text.isNotEmpty) {
                              setState(() {
                                addReply(index, replyController.text);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
