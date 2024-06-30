
import 'package:flutter/material.dart';

class InstagramPost extends StatefulWidget {
  @override
  _InstagramPostState createState() => _InstagramPostState();
}

class _InstagramPostState extends State<InstagramPost> {
  bool _isLiked = false;
  bool _showComments = false;
  int _likeCount = 0;
  List<String> _comments = [];

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
  }

  void _toggleComments() {
    setState(() {
      _showComments = !_showComments;
    });
  }

  void _addComment(String comment) {
    setState(() {
      _comments.add(comment);
    });
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram-like Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 490,
          color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                  child: Icon(Icons.person)
                ),
                title: Text("ddddddddddd"),
                subtitle: Text("dddddddddd"),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'This is an Instagram-like post!',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Image.network(
                'https://via.placeholder.com/400',
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.red : null,
                    ),
                    onPressed: _toggleLike,
                  ),
                  Text('$_likeCount likes'),
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: _toggleComments,
                  ),
                ],
              ),
              if (_showComments) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Comments',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      // List of last comments
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _comments.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_comments[index]),
                          );
                        },
                      ),
                      // Add a comment section
                      SizedBox(height: 16),
                      Text(
                        'Add a Comment',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(hintText: 'Add a comment...'),
                              onSubmitted: _addComment,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              // Handle sending the comment
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}




class ExpansionTileExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExpansionTile Example'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return MyExpansionTile(
            title: 'Tile $index',
            children: List.generate(3, (index) => ListTile(title: Text('Subtile $index'))),
          );
        },
      ),
    );
  }
}

class MyExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const MyExpansionTile({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      color: Colors.amber,
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.black,
          ),
          ExpansionTile(
            title: Text(title),
            children: children,
          ),
        ],
      ),
    );
  }
}
