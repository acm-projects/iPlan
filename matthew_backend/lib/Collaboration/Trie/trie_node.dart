/// Handles the representation of an individual node within the [Trie] data structure
class TrieNode {
  /// The value of the current [TrieNode] object represented as a [String]
  late String _id;
  /// The list of children that this node connects to represented as [List<TrieNode>]
  late List<TrieNode> _children;

  /// Creates a [TrieNode] object with an ID equal to the passed parameter [id]
  TrieNode({required String id}) {
    _id = id;
    _children = <TrieNode>[];
  }

  /// Adds the passed node to this node's list of children
  void addChild(TrieNode child) {
    _children.add(child);
  }

  /// Removes the passed [TrieNode] from the this node's list of children
  bool removeChild(TrieNode child) {
    return _children.remove(child);
  }

  /// Returns the ID of the current node represented as a [String]
  String getID() {
    return _id;
  }

  /// Returns the list of this current node's children represented as a [List<TrieNode>]
  List<TrieNode> getChildren() {
    return _children;
  }

  /// Returns [true] if the current node has a child with [_id] equal to [char]
  bool containsChar(String char) {
    for(TrieNode child in _children) {
      if(child.getID() == char) {
        return true;
      }
    }
    return false;
  }

  /// Returns whether or not the current TrieNode is a leaf or not.
  bool isLeaf() {
    return _children.isNotEmpty;
  }


}