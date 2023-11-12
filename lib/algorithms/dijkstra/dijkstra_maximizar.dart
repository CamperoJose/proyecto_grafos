import 'dart:collection';

class Graph {
  Map<String, Map<String, int>> adjList = {};

  void addEdge(String src, String dest, int weight) {
    if (!adjList.containsKey(src)) {
      adjList[src] = {};
    }
    if (!adjList.containsKey(dest)) {
      adjList[dest] = {};
    }
    adjList[src]![dest] = weight;
  }

  List<String> topologicalSort() {
    Set<String> visited = Set<String>();
    List<String> stack = [];
    for (String node in adjList.keys) {
      topologicalSortUtil(node, visited, stack);
    }
    return stack;
  }

  void topologicalSortUtil(String v, Set<String> visited, List<String> stack) {
    if (!visited.contains(v)) {
      visited.add(v);
      adjList[v]?.forEach((u, weight) {
        topologicalSortUtil(u, visited, stack);
      });
      stack.insert(0, v);
    }
  }

  List<List<String>> longestPath(String start, String end) {
    var order = topologicalSort();
    Map<String, int> distances = {};
    Map<String, String?> previous = {};

    for (String node in adjList.keys) {
      distances[node] = double.minPositive.toInt();
      previous[node] = null;
    }

    distances[start] = 0;

    for (String node in order) {
      if (node == start || distances[node] != double.minPositive.toInt()) {
        adjList[node]?.forEach((next, weight) {
          int totalDistance = distances[node]! + weight;
          if (totalDistance > distances[next]!) {
            distances[next] = totalDistance;
            previous[next] = node;
          }
        });
      }
    }

    if (distances[end] == double.minPositive.toInt()) {
      // No hay camino desde el inicio hasta el final
      return [];
    }

    List<List<String>> path = [];
    for (String at = end; previous[at] != null; at = previous[at]!) {
      path.insert(0, [previous[at]!, at]);
    }

    return path;
  }
}