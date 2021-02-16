---
date: 2021-02-16 10:40:23
layout: post
title: MVC Architecture Practice - View
description: Java를 통해 MVC구조를 연습해보고, 이전 시간에 배운 Map을 활용하여 더욱 풍부한 문법을 연습해본다.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
# MVC 구조 실습

MVC구조 중 오늘 실습에 해당하는 부분은 View이다.

![boardClassDiagram](https://user-images.githubusercontent.com/68142821/108051836-b2a8b580-708e-11eb-95f1-c753abeff4ee.png)

## View

View는 MVC구조에서 사용자와 밀접하게 지내야 하는 부분을 의미한다.
우리가 UI로 보는 어플리케이션이나, 웹 뷰 등 서비스를 사용하는 사람들은 내부적인 구조를 알아가면서 사용하는 것이 아니다.

즉, 코딩을 하나도 모르는 사람들에게 우리는 선택권을 주면서, 그 선택에 대한 보장을 해주어야 한다는 것이다. 잘 이해가 가지 않는다면 이것을 나름대로 표현해보겠다.
ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
1. 학생 정보 추가
2. 학생 정보 제거
3. 학생 리스트 출력
4. 종료

ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

다음 중 숫자를 입력하는 것에서 내부적인 코드를 알아야 할까?
당연히 아닐 것이다. 우리는 사용자로부터 직접 원하는 입력을 받을 수 있도록 노력하는 것 뿐이다.
그러나 이번 실습에서는 사용자로부터 직접 입력 받는 것이 아닌, 임의의 값으로 실험할 수 있도록 해보았다.

### MainView.java
```java
import kosta.exam.controller.BoardController;
import kosta.exam.dto.ArchiveBoard;
import kosta.exam.dto.PhotoBoard;

public class MainView {

	public static void main(String[] args) {
		//1.archive와 photo 모든 게시물 검색
		System.out.println("1. 모든 게시물 검색");
		BoardController.getAllBoard();
		
		
		System.out.println("\n");
		
		//2. archive 또는 photo  게시판에 있는 모든 게시물 검색
		System.out.println("2. 게시판 유형에 따른 검색");  
		
		System.out.println("2-1.게시판유형이 존재하는 경우.....");
		BoardController.getBoardByKind("archive");
		
		BoardController.getBoardByKind("photo");
		
		System.out.println("2-2.게시판유형이 없는 경우.....");
		BoardController.getBoardByKind("test");
		
		
		System.out.println("\n");
		
		/*3.글번호에 해당하는 자료실검색
		 존재하는 게시물 검색할 경우와 없는 게시물 검색 각각 test 결과 출력하기*/
		 
		System.out.println("3.Board에서 글번호에 해당하는 게시물 검색");
		System.out.println("-----게시물이 존재하는 경우 검색 test----- ");
		BoardController.getBoardByNo("archive", 10); //존재하는 게시물
		
		System.out.println();
		
		System.out.println("-----게시물이 없는 경우(글번호 오류)  검색 test-----");
		BoardController.getBoardByNo("archive", 50);// 없는 게시물
		
                System.out.println();
		
		System.out.println("-----게시물이 없는 경우(kind오류)  검색 test-----");
		BoardController.getBoardByNo("test", 10);// 없는 게시물
		
		System.out.println("\n");
		
		
		//4. 등록하기
		System.out.println("--4-1. 등록하기(성공!!)");
		BoardController.insertBoard("photo" ,
				new PhotoBoard(40, "mvc공부", "장희정111", "재미있다.", "2018-08-18", "a.jpg"));
		
		System.out.println("--4-2. 등록하기(실패!! - 글번호 중복!)");
		BoardController.insertBoard("photo" ,
				new PhotoBoard(10, "mvc공부", "장희정", "재미있다.", "2018-08-18", "a.jpg"));
		
		System.out.println("--4-2. 등록하기(실패!! - kind 잘못!!!!)");
		BoardController.insertBoard("photo2" ,
				new PhotoBoard(50, "mvc공부", "장희정", "재미있다.", "2018-08-18", "a.jpg"));
		
		
		System.out.println("---검색하기 --------");
		BoardController.getAllBoard();
		
		System.out.println("--5. 삭제하기..............");
		System.out.println("---5-1. 삭제성공하기-----------------");
                BoardController.deleteBoard("photo", 20);
        
        
                System.out.println("---5-2. 삭제실패하기(kind 오류) -----------------");
                BoardController.deleteBoard("test", 20);
        
        
                System.out.println("---5-3. 삭제실패하기(글번호 오류) -----------------");
                BoardController.deleteBoard("photo", 70);
        
                System.out.println("---검색하기 --------");
		BoardController.getAllBoard();
		
		System.out.println("---6.수정하기----------------");
		System.out.println("--6-1. photo수정 완료-----------------");
		BoardController.updateBoard(new PhotoBoard(10, "점심시간", "이효리", "뭐 먹지??", null, "test.gif") , "photo");
		
		System.out.println("--6-2. archive수정 완료-----------------");
		BoardController.updateBoard(new ArchiveBoard(10, "점심시간", "이효리", "뭐 먹지??", null, "a.xls",300) , "archive");
		
		//게시판유형 잘못
		System.out.println("--6-3. 수정실패(kind 잘못) -----------------");
		BoardController.updateBoard(new ArchiveBoard(10, "점심시간", "이효리", "뭐 먹지??", null, "a.xls",300) , "test");
	
		System.out.println("--6-3. 수정실패(no 잘못) -----------------");
		BoardController.updateBoard(new ArchiveBoard(80, "점심시간", "이효리", "뭐 먹지??", null, "a.xls",300) , "archive");
	
		 
                System.out.println("---검색하기 --------");
		BoardController.getAllBoard();
	}
}
```

### SuccessView.java
성공적인 출력이 예상된다면 다음 View를 이용하여 출력할 수 있도록 한다.
```java
import java.util.Map;

import kosta.exam.dto.Board;

public class SuccessView {
	public SuccessView() {}
	public static void printBoard(Map<String, Map<String, Board>> map) {
		for(Map.Entry<String, Map<String, Board>> keyMap : map.entrySet()) {
			String k = keyMap.getKey();
			System.out.println("====" + k + "의 모든 게시물 ====");
			Map<String, Board> v = keyMap.getValue();
			for(Map.Entry<String, Board> valueMap : v.entrySet()) {
				String key = valueMap.getKey();
				Board value = valueMap.getValue();
				System.out.println("key = " +  key + " [ " + value + " ] ");
			}
		}
	}
	
	public static void printBoardByKind(String kind, Map<String, Board> map) {
		System.out.println("==== " + kind + "유형 게시물 List ====");
		for(Map.Entry<String, Board> printMap : map.entrySet()) {
			String key = printMap.getKey();
			Board value = printMap.getValue();
			System.out.println("번호 : " + key + ", " + value);
		}
	}
	
	public static void printBoardByNo(Board board) {
		System.out.println(board);
	}
	
	public static void printMessage(String message) {
		System.out.println(message);
	}
}
```

### FailView.java
사용자의 선택이 실패로 예상된다면 다음 View를 이용하여 출력할 수 있도록 한다.
```java
public class FailView {
	FailView() {}
	public static void errorMessage(String message) {
		System.out.println(message);
	}
}
```

## Exception
이번 실습에서는 사용자 정의 Exception을 추가하였다.
InexistException은 존재하지 않는 번호의 사용자 접근을 방지하기 위한 예외이며
DuplicateException은 key값이 중복되지 않도록 유일성을 위한 예외이다.

### InexistException.java
```java
public class InexistentException extends RuntimeException {
	public InexistentException() {}
	public InexistentException(String message) {
		super(message);
	}
}
```

### DuplicateException.java
```java
public class DuplicateException extends RuntimeException {
	public DuplicateException() {}
	public DuplicateException(String message) {
		super(message);
	}
}
```