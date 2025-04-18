import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nq_mall_dashboard/models/value_model.dart';

class TreeNode<T> {
  T? data;
  List<TreeNode> children = [];
  TreeNode({
    this.data,
  });

  bool haveChildren() {
    return children.isNotEmpty;
  }

  void addChild(TreeNode<T> child) {
    children.add(child);
  }

  TreeNode copyWith({
    ValueModel? data,
    List<TreeNode>? children,
  }) {
    return TreeNode(
      data: data ?? this.data,
    );
  }

  @override
  String toString() => 'TreeNode(data: $data, children: $children)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TreeNode &&
        other.data == data &&
        listEquals(other.children, children);
  }

  @override
  int get hashCode => data.hashCode ^ children.hashCode;

  void printTree(TreeNode? node, [String indent = '']) {
    // String data = '';
    node ??= this;
    print('$indent${node.data.ValueAr}');
    // data += '$indent${node.data.ValueAr} \n';
    for (var child in node.children) {
      // data += '$indent ${child.data.ValueAr} \n';
      printTree(child, indent + '  ');
    }
    // print(data);
  }
}
