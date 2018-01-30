<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		// 다익스트라.
		Graph.prototype.shortest = function(startKey) {
			var from = this.first;
			while (from) {
				if (from.key === startKey) {
					break;
				}

				from = from.next;
			}
			console.log('시작점은 %s입니다', from.key);
			var temp = this.first;
			var current;
			var arc;
			while (temp) { // 모든 버텍스 최단거리를 Infinity로 초기화
				temp.distance = Infinity;
				temp = temp.next;
			}
			temp = this.first;
			temp.distance = 0;
			while (temp) { // 반복문을 돌며 최단 거리를 찾음
				current = temp;
				temp = temp.next;
				arc = current.arc;
				while (arc) {
					if (arc.destination.distance > current.distance + arc.data) {
						arc.destination.distance = current.distance + arc.data;
					}
					arc = arc.nextArc;
				}
			}
			temp = this.first;
			while (temp) {
				console.log('%s까지의 최단 거리는 %d입니다', temp.key, temp.distance);
				temp = temp.next;
			}
		};

		var graph = new Graph();
		graph.insertVertex('A');
		graph.insertVertex('B');
		graph.insertVertex('C');
		graph.insertVertex('D');
		graph.insertVertex('E');
		graph.insertVertex('F');
		insertTwoWayArc(graph, 6, 'A', 'B');
		insertTwoWayArc(graph, 3, 'A', 'C');
		insertTwoWayArc(graph, 2, 'B', 'C');
		insertTwoWayArc(graph, 5, 'B', 'D');
		insertTwoWayArc(graph, 3, 'C', 'D');
		insertTwoWayArc(graph, 4, 'C', 'E');
		insertTwoWayArc(graph, 2, 'D', 'E');
		insertTwoWayArc(graph, 3, 'D', 'F');
		insertTwoWayArc(graph, 5, 'E', 'F');
		graph.shortest('A');
		// A까지의 최단 거리는 0입니다.
		// B까지의 최단 거리는 5입니다.
		// C까지의 최단 거리는 3입니다.
		// D까지의 최단 거리는 6입니다.
		// E까지의 최단 거리는 7입니다.
		// F까지의 최단 거리는 9입니다.
	</script>
	<input type="text">

</body>
</html>