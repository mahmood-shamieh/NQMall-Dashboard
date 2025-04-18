import 'dart:convert';

import 'package:nq_mall_dashboard/models/tree_node.dart';

class Tree<T> {
  late TreeNode<T> root;
  Tree({
    required this.root,
  });

  void addChild(TreeNode<T> parent, TreeNode<T> child) {
    parent.addChild(child);
  }

  void printTree(TreeNode node, [String indent = '']) {
    print('$indent${node.toString()}');
    for (var child in node.children) {
      printTree(child, indent + '  ');
    }
  }
}
