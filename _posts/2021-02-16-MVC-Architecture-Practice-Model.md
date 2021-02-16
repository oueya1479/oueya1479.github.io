---
date: 2021-02-16 10:32:11
layout: post
title: MVC Architecture Practice - Model
description: Java를 통해 MVC구조를 연습해보고, 이전 시간에 배운 Map을 활용하여 더욱 풍부한 문법을 연습해본다.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
# MVC 구조 실습
본격적으로 MVC구조에 대한 실습을 해보려고 한다.
이 구조에 대해 이전 Post에서도 나름 작성한 것을 게시해보았지만,
구조에 대한 미흡한 부분도 많고, 조금 더 뚜렷하게 해보자는 마음으로 새롭게 구현해보려고 한다.

다음 사진은 잘 작아서 보이지 않겠지만, MVC구조를 가지고 interface와 사용자 정의 exception을 포함하여
구현하려는 전체적인 내용이다.

![boardClassDiagram](https://user-images.githubusercontent.com/68142821/108051836-b2a8b580-708e-11eb-95f1-c753abeff4ee.png)

## Model
직접 만들어보면서 이해하게 된 내용은 이렇다.

사용자로부터 입력을 받아 Controller에서 정리를 해주고, Controller는 사용자의 요청을 수행할 수 있는 기능을 가진 장소를 선택한다. 즉, Model은 Controller로부터 받은 요청을 수행할 수 있는 단계이다. 그렇기 때문에 역할을 수행할 수 있는 **모든 정보와 데이터**를 갖고 있어야 한다는 것이다.

또한 실질적인 기능을 수행하는 부분이라 View나 Controller보다 먼저 구현하는 것이 편했다.

나는 Map을 활용해서 게시글을 올리는 연습을 할 것이며,
게시글에 대한 정보는 '이미지를 올릴 수 있는 게시판', '첨부 파일을 올릴 수 있는 게시판'으로 나누어 사용자에게 제공해 줄 것이다.

게시물에 대한 정보를 저장할 수 있는 Class를 Board라고 지정하고,
ArchiveBoard와 PhotoBoard가 Board를 상속할 수 있도록 한다.

### Board.java
```java
public class Board {
	private int no;
	private String subject;
	private String writer;
	private String content;
	private String date;
	
	public Board() {}
	public Board(int no, String subject, String writer, String content, String date) {
		super();
		this.no = no;
		this.subject = subject;
		this.writer = writer;
		this.content = content;
		this.date = date;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "번호 : " + no + ", 제목 : " + subject +
				", 작성자 : " + writer + ", 내용 : " + content + ", 날짜 : "+ date;
	}
}
```

### ArchiveBoard.java
```java
public class ArchiveBoard extends Board{
	private String fileName;
	private int fileSize;
	
	public ArchiveBoard() { }
	public ArchiveBoard(int no, String subject, String writer, String content, String date, String fileName, int fileSize) {
		super(no, subject, writer, content, date);
		this.fileName = fileName;
		this.fileSize = fileSize;
	}
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	@Override
	public String toString() {
		return super.toString() + ", 첨부파일 이름 : " + fileName + ", 파일 용량 : " + fileSize;
	}
}
```

### PhotoBoard.java
```java
public class PhotoBoard extends Board{
	private String imgName;
	Object obj;
	
	public PhotoBoard() { }
	public PhotoBoard(int no, String subject, String writer, String content, String date, String imgName) {
		super(no, subject, writer, content, date);
		this.imgName = imgName;
	}
	
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	
	@Override
	public String toString() {
		return super.toString() + ", 이미지 이름 : " + imgName;
	}
}
```

여기까지가 DTO에 대한 작업이라고 볼 수 있겠다.
DTO에 대한 형식은 항상 하는 작업이라 철자만 틀리지 않으면 어렵지 않게 넘어가는 것 같다.

다음은 Service에 대한 부분이다.
이 프로그램에 대한 전체적인 기능을 수행하고, 예외 지정, 던지기 등 가장 머리를 써야 하는 부분이다.
Service는 먼저 interface를 구현하여 앞으로 사용할 메소드를 정의하는 부분을 넣어주었다.
다음은 Service에 대한 부분이다.
이 프로그램에 대한 전체적인 기능을 수행하고, 예외 지정, 던지기 등 가장 머리를 써야 하는 부분이다.
Service는 먼저 interface를 구현하여 앞으로 사용할 메소드를 정의하는 부분을 넣어주었다.
### Service.java(interface)
```java
/**
 * 모든 게시판이 공통으로 사용하게 될 Service
 * (Business Logic)
 * */

import java.util.Map;
import kosta.exam.dto.Board;
import kosta.exam.exception.DuplicateException;
import kosta.exam.exception.InexistentException;

public interface BoardService {
   /**
    *   모든 게시물 검색
    *   @return : 게시판 유형에 따른 모든 게시물 정보를 Map의 형태로 리턴
    *   @throws : 게시물이 한개도 존재 하지 않는다면 InexistentException 예외가
    *             발생한다.
    * */
	Map<String, Map<String, Board>> getBoardList()throws InexistentException;
	
	/**
	 *게시판의유형(Kind)에 따른 게시물 검색하기
	 *  @return kind에 해당하는 전체게시물 Map으로 리턴
	 *  @param :  게시물유형에 따른 key를 인수로 전달받는다.
	 *  @throws : kind에 해당하는 게시물이 한개도 없을 때 InexistentException 예외 발생
	 * */
	Map<String, Board> getBoardByKind(String kind)throws InexistentException;
	
	/**
	 *  게시물 유형에서 글번호에 해당하는 게시물 한개를 검색
	 * @return 게시물 정보 한개를 Board 형태로 리턴
	 * @param kind는 게시물 유형, no는 게시물 글번호
	 * @throws 검색하는 게시물이 없으면 InexistentException 예외발생
	 * */
	Board getBoardByNo(String kind, int no)throws InexistentException;
	
	/**
	 *  게시물 등록하기
	 *  @return : true이면  등록성공, false이면 등록실패
	 *  @param : kind는 추가할 게시판유형, board는 추가할 게시물의 정보
	 *  @throws: 등록하기 전에 글번호 중복을 체크해서 중복이면 DuplicateException발생
	 *           등록을 실패하면  InexistentException 발생
	 * */
	boolean insertBoard(String kind, Board board)throws DuplicateException, InexistentException;

        /**
         * 5. 등록전에 번호 중복여부 체크 하는 기능
         *    @return : true이면 중복, false이면 중복아님.
         *    @param : kind의 게시판의 유형, no는 글번호
         * */
	boolean duplicateByNo(String kind, int no);
	
	/**
	 * 6. 게시물 삭제하기
	 *  @return : true이면 삭제성공, false이면 삭제실패
	 *  @param : kind의 게시판의 유형, no는 글번호
	 *  @throws : 삭제가 되지 않으면 InexistentException 예외 발생.
	 * */
	boolean deleteBoard(String kind, int no)throws InexistentException;
	
	/**
	 * 7. 게시물 수정하기
	 *     공통 : 제목, 작성자, 내용
	 *     photo : imgName
	 *     archive : fileName, fileSize
	 *     
	 * @param : board는 수정할 게시물의 정보, kind는 수정될 게시물이있는 게시판의유형
	 * @throws: 수정되지 않으면 InexistentException 예외발생
	 * */
	boolean updateBoard(Board board, String kind)throws InexistentException;
}
```

### BoardService.java
생성자 부분을 보면 게시물에 대한 초기 값을 전달해주기 위해 Properties를 활용하여 파일을 로딩하는 부분이 있다.
저번 Map에서 실습할 때에 진행한 것이며, Map을 중점적으로 사용해보기 위해 Properties파일을 제작하여 그 안에 초기 값을 넣어두었다.
```java
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;
import kosta.exam.dto.ArchiveBoard;
import kosta.exam.dto.Board;
import kosta.exam.dto.PhotoBoard;
import kosta.exam.exception.DuplicateException;
import kosta.exam.exception.InexistentException;

public class BoardServiceImpl implements BoardService {
	Map<String, Map<String, Board>> allBoardList = new HashMap<String, Map<String, Board>>();
	private static BoardServiceImpl instance = new BoardServiceImpl();
	
	private BoardServiceImpl() {
		
		Map<String, Board> amap = new HashMap<String, Board>();
		Map<String, Board> pmap = new HashMap<String, Board>();
		
		//archive 파일 로딩해서 객체로 만들고 Map에 넣기
		ResourceBundle rb = ResourceBundle.getBundle("kosta/exam/service/archiveInfo");
		for(String key : rb.keySet()) {
			String value = rb.getString(key);
			String v [] = value.split(",");
			ArchiveBoard board = new ArchiveBoard(Integer.parseInt(v[0]), v[1], v[2], v[3], v[4], v[5], Integer.parseInt(v[6]));
			amap.put(key, board);
		}
		//photo로딩해서 객체로 만들고 Map에 넣기
		rb = ResourceBundle.getBundle("kosta/exam/service/photoInfo");
		for(String key : rb.keySet()) {
			String value = rb.getString(key);
			String v [] = value.split(",");
			PhotoBoard board = new PhotoBoard(Integer.parseInt(v[0]), v[1], v[2], v[3], v[4], v[5]);
			pmap.put(key, board);
		}
		//위 각각의 Map을 allBoard
		allBoardList.put("archive", amap);
		allBoardList.put("photo", pmap);
	}
	
	public static BoardServiceImpl getInstance() {
		return instance;
	}
	
	@Override
	public Map<String, Map<String, Board>> getBoardList() {
		return allBoardList;
	}

	@Override
	public Map<String, Board> getBoardByKind(String kind) {
		Map<String, Board> map = allBoardList.get(kind);
		if(map == null) {
			throw new InexistentException();
		}
		return map;
	}

	@Override
	public Board getBoardByNo(String kind, int no) {
		Map<String, Board> map = allBoardList.get(kind);
		if(map == null) throw new InexistentException(kind);
		Board board = map.get(Integer.toString(no));
		if(board == null) throw new InexistentException(Integer.toString(no));
		return board;
	}

	@Override
	public boolean insertBoard(String kind, Board board) {
		if(!duplicateByNo(kind, board.getNo())) {
			Map<String, Board> map = new HashMap<String, Board>();
			map.put(Integer.toString(board.getNo()), board);
			allBoardList.get(kind).put(Integer.toString(board.getNo()), board);
			return true;
		} else {
			throw new DuplicateException();
		}
	}

	@Override
	public boolean duplicateByNo(String kind, int no) {
		Map<String, Board> map = allBoardList.get(kind);
		if(map == null) throw new InexistentException();
		Board board = map.get(Integer.toString(no));
		if(board == null) return false;
		return true;
	}

	@Override
	public boolean deleteBoard(String kind, int no) {
		if(duplicateByNo(kind, no)) {
			allBoardList.get(kind).remove(Integer.toString(no));
			return true;
		}
		return false;
	}

	@Override
	public boolean updateBoard(Board board, String kind) {
		if(duplicateByNo(kind, board.getNo())) {
			allBoardList.get(kind).put(Integer.toString(board.getNo()), board);
			return true;
		}
		return false;
	}
}
```

### archiveInfo.properties
무슨 말인지 이해가 안 되겠지만, eclipse에서 properties의 확장자 파일을 제작하여 그 안에 한글을 넣으면 다음과 같이 자동 대입을 해준다.
~~편리한 eclipse~~
```java
#key=no,subject,writer,content,date,fileName,fileSize
10=10,Java\uAD50\uC548\uC790\uB8CC,\uC774\uCC2C\uBC94,\uC790\uBC14\uC218\uC5C5\uC744 \uC6B0\uD55C \uC790\uB8CC,2017-03-27,java.ppt,200
20=20,struts2\uC218\uC5C5,\uC774\uAC00\uD604,struts2\uC218\uC5C5\uC740 \uC5B4\uB5A8\uAE4C??,2017-03-25,struts2.ppt,500
```

### photoInfo.properties
```java
#key=no,subject,writer,content,date,imgName
10=10,kcb\uC778\uD134\uAD50\uC721,\uC7A5\uD76C\uC815,\uBAA8\uB450 \uD654\uC774\uD305!,2017-03-23,love.gif
20=20,\uBCF4\uC548\uAD50\uC721,\uD64D\uAE38\uB3D9,\uC790\uBC14 \uBCF4\uC548\uC774\uB780?,2017-04-01,test.gif
30=30,\uD55C\uAD6D\uB370\uC774\uD130\uBCA0\uC774\uC2A4\uC9C4\uD765\uC6D0,\uC7A5\uD76C\uC815,\uC815\uB9D0 \uC88B\uC740 \uAD50\uC721!!,2017-03-25,girl.gif
```