package com.sns.datatest;

 


import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Deque;
import java.util.List;
import java.util.Scanner;
 
 

/**
 * 외판원 순회(TSP) DP + Bit mask
 * BOJ2098과 같은 문제
 * 
 * @author quki
 *
 */
 

public class tsp {


	public static int[][] W;
	public static int[][] dp;
	public static int[] city = new int[10];
	public static int N;
	public static final int INF = 1000000000;
	
	//stack of numbers of towns on the route so far
	private static Deque<Integer> route = new ArrayDeque<>();
	//shortest route found
	private static List<Integer> solution;

	/**
	 * 
	 * @param start 시작점
	 * @param visited 현재까지 경로
	 * @return
	 */
 
	public static int getShortestPath(int current, int visited, int count) {
		

//		Deque<Integer> route = new ArrayDeque<>();
		
		// 모든 정점을 다 들른 경우
		if (visited == (1 << N) - 1) {
			
			//city 마지막에 1을 더함.
//			city[N] = 1;
//			System.out.print("city : ");
//			for(int i = 0; i <= N; i++) {
//				System.out.print(city[i] + " ");
//			}	
//			System.out.println();
			
			route.push(1);
			
//			//route 출력
//			System.out.print("route : " );
//			for(int k : route) {
//				System.out.print( k + " ");
//			}
//			System.out.println();
			
			//1까지 경로 리턴
			return W[current][1];
		}


		// 이미 들렀던 경로이므로 바로 return
//		if (dp[current][visited] >= 0) {
//			System.out.println("이미 들렀던 경로");
//			System.out.println("visited : " + visited);
//			return dp[current][visited];
//		}
		

		int ret = INF;

		
		// 집합에서 다음에 올 원소를 고르자!
		for (int i = 1; i <= N; i++) {
			int next = i;
			city[count-1] = i;
			
			if ((visited & (1 << (next - 1))) != 0) // 이미 들렀던 곳일때 pass
				continue;

			if(W[current][next] == 0) // 0은 경로가 없으므로 pass
				continue;
			
			route.push(i);
			//after having tried town i, remove it from route again before trying next town
			int temp = W[current][next] + getShortestPath(next, visited + (1 << (next - 1)), count+1);
//			route.pop();
//			System.out.println("j : " + j);
			if(ret > temp) {
				System.out.println("갱신");
				solution = new ArrayList<>(route);
				System.out.println(route.toString());
				route.pop();
			}else {
//				route.pop();
			}

			ret = Math.min(ret, temp);
			
		}
 

		
//		String s = "";
//		String s2 = "";
//		for (int i = 0; i < Integer.numberOfLeadingZeros(visited); i++) s += "0"; // 0을 빈자리 개수만큼 만들어 전진 배치
//	    s += Integer.toBinaryString(visited); // 10진수를 2진수화하여 합치기
//	    for (int i = 0; i < 32; i+= 8) s2 += s.substring(i, i+8) + " " ;
//
//		System.out.println("current :  " + current + " /visited : " + s2+ " /dp : " + ret);

//		System.out.print("solution : ");
//		for(int i : solution) {
//			System.out.print( i + " ");
//		}
//		System.out.println();
		System.out.println("route : ");
		for(int i : route) {
			System.out.print(i + " ");
		}System.out.println();
//		System.out.println("ret : " + ret);
		

//		solution = new ArrayList<>(route);

		
		return dp[current][visited] = ret;

	}

	public static void main(String[] args) {
		
		
		Scanner sc = new Scanner(System.in);
		N = sc.nextInt();
		W = new int[N + 1][N + 1];
		city = new int[N + 1];
		dp = new int[N + 1][1 << N];
		for (int i = 1; i <= N; i++) {
			city[i] = -1;
			for (int j = 1; j <= N; j++) {
				W[i][j] = sc.nextInt();
			}
		}
		

		// 2차원 배열의 모든 원소를 -1로
		for (int i = 1; i <= N; i++) {
			Arrays.fill(dp[i], -1);
		}
		
		int start = 1;
		city[0] = 1;
		System.out.println(getShortestPath(start, 1, 2));
		
		System.out.print("solution : ");
		for(int i : solution) {
			System.out.print(i + " ");
		}
	}

}