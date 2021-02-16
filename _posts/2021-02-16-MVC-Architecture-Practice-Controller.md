---
date: 2021-02-16 10:50:23
layout: post
title: MVC Architecture Practice - Controller
description: Java를 통해 MVC구조를 연습해보고, 이전 시간에 배운 Map을 활용하여 더욱 풍부한 문법을 연습해본다.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->

# MVC 구조 실습

MVC구조 중 오늘 실습에 해당하는 부분은 Controller이다.

![boardClassDiagram](https://user-images.githubusercontent.com/68142821/108051836-b2a8b580-708e-11eb-95f1-c753abeff4ee.png)

## Controller
우리는 사용자에게 선택권을 주기도, 사용자로부터 입력을 받아 그 기능을 수행하는 부분도 모두 Model과 View로 이루었다.

사용자의 요청이 들어오기 시작할 때부터 그 기능을 수행하기 전까지 **한 구역**을 거쳐야만, 이를 테면 통로 같은 부분이 있어야 정상적으로 수행할 것이다. 나는 Controller을 컴퓨터의 CPU라고 생각한다. 모든 명령의 중앙 처리 장치이며, Brain에 해당하는 역할이기 때문이다.

**Controller**는 사용자의 요청으로 그 기능을 수행해야 하는 메소드를 가리키는 역할을 한다.
이렇게 말하면 정말 작은 역할을 담당하는 것처럼 보이기도 하겠다.

하지만 Model로부터 나오는 모든 예외 처리나 새로운 View를 제공하는 임무, 기능이 성공인지 실패인지 가늠하는 가장 중요한 역할이기도 하다. 위 이미지에서는 하나의 노란색 박스에 불과하지만, **사용자와 개발자를 이어주는 징검다리**같은 역할의 Controller는 program에 있어 매우 중요한 역할을 한다.

### BroadController.java
```java
import java.util.Map;

import kosta.exam.dto.Board;
import kosta.exam.exception.DuplicateException;
import kosta.exam.exception.InexistentException;
import kosta.exam.service.BoardService;
import kosta.exam.service.BoardServiceImpl;
import kosta.exam.view.FailView;
import kosta.exam.view.SuccessView;

public class BoardController {
	private static BoardService boardService = BoardServiceImpl.getInstance();
	public BoardController() {}
	
	public static void getAllBoard() {
		try {
			Map<String, Map<String, Board>> map = boardService.getBoardList();
			if(map == null) {
				throw new InexistentException();
			} else {
				SuccessView.printBoard(map);
			}
		} catch (InexistentException e) {
			FailView.errorMessage("게시물이 존재하지 않습니다.");
		}
	}
	
	public static void getBoardByKind(String kind) {
		try {
			Map<String, Board> map = boardService.getBoardByKind(kind);
			SuccessView.printBoardByKind(kind, map);
		} catch(InexistentException e) {
			FailView.errorMessage("존재하지 않는 유형입니다.");
		}
	}
	
	public static void getBoardByNo(String kind, int no) {
		try {
			Board board = boardService.getBoardByNo(kind, no);
			SuccessView.printBoardByNo(board);
		} catch(InexistentException e) {
			if(e.getMessage().equals(kind))
				FailView.errorMessage("존재하지 않는 유형입니다.");
			else if(e.getMessage().equals(Integer.toString(no))) {
				FailView.errorMessage("존재하지 않는 글 번호입니다.");
			}
		}
	}
	
	public static void insertBoard(String kind, Board board) {
		try {
			if(boardService.insertBoard(kind, board)) {
				SuccessView.printMessage("성공적으로 등록되었습니다.");
			}
		} catch(DuplicateException e) {
			FailView.errorMessage("이미 존재하는 글 번호입니다.");
		} catch (InexistentException e) {
			FailView.errorMessage("존재하지 않는 유형입니다.");
		}
	}
	
	public static void deleteBoard(String kind, int no) {
		try {
			if(boardService.deleteBoard(kind, no)) {
				SuccessView.printMessage("성공적으로 삭제되었습니다.");
			} else {
				FailView.errorMessage("존재하지 않는 글 번호입니다.");
			}
		} catch (InexistentException e) {
			FailView.errorMessage("존재하지 않는 유형입니다.");
		}
	}

	public static void updateBoard(Board board, String kind) {
		try {
			if(boardService.updateBoard(board, kind)) {
				SuccessView.printMessage("성공적으로 수정되었습니다.");
			} else {
				FailView.errorMessage("존재하지 않는 글 번호입니다.");
			}
		} catch (InexistentException e) {
			FailView.errorMessage("존재하지 않는 유형입니다.");
		}
	}
}
```