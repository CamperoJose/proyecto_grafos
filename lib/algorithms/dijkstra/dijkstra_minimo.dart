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

  List<List<String>> dijkstra(String start, String end) {
    Map<String, int> distances = {};
    Map<String, String?> previous = {};
    Set<String> visited = Set<String>();

    adjList.forEach((node, _) {
      distances[node] = double.maxFinite.toInt();
      previous[node] = null;
    });

    distances[start] = 0;

    while (visited.length != adjList.length) {
      String? closest = distances.keys
          .where((node) => !visited.contains(node))
          .reduce((a, b) => distances[a]! < distances[b]! ? a : b);

      if (closest == null || distances[closest] == double.maxFinite.toInt()) {
        break;
      }

      if (closest == end) {
        break;
      }

      visited.add(closest);

      adjList[closest]!.forEach((neighbor, weight) {
        int totalDistance = distances[closest]! + weight;
        if (totalDistance < distances[neighbor]!) {
          distances[neighbor] = totalDistance;
          previous[neighbor] = closest;
        }
      });
    }

    List<String> fullPath = [];
    String? current = end;
    while (current != null && previous[current] != null) {
      fullPath.insert(0, current);
      current = previous[current];
    }
    if (current == start) {
      fullPath.insert(0, start);
    }

    // Convertir fullPath a una lista de listas
    List<List<String>> pathInSteps = [];
    for (int i = 0; i < fullPath.length - 1; i++) {
      pathInSteps.add([fullPath[i], fullPath[i + 1]]);
    }

    return pathInSteps;
  }
}

