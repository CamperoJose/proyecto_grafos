class DisjointSet {
  Map<String, String> parent = {};

  void makeSet(List<String> nodes) {
    for (String node in nodes) {
      parent[node] = node;
    }
  }

  String find(String k) {
    if (parent[k] == k) {
      return k;
    }
    return find(parent[k]!);
  }

  void union(String a, String b) {
    String x = find(a);
    String y = find(b);
    parent[x] = y;
  }
}

List<List<String>> runKruskalAlgorithm(List<List<dynamic>> edges, List<String> nodes) {
  List<List<String>> MST = [];
  DisjointSet ds = DisjointSet();
  ds.makeSet(nodes);

  int index = 0;
  edges.sort((a, b) => a[2].compareTo(b[2]));

  while (MST.length != nodes.length - 1) {
    List<dynamic> edge = edges[index];
    index++;

    String x = ds.find(edge[0]);
    String y = ds.find(edge[1]);

    if (x != y) {
      MST.add([edge[0], edge[1]]);
      ds.union(x, y);
    }
  }

  return MST;
}
