---
date: 2021-02-18 11:25:52
layout: post
title: Java IOStream
description: 지금까지의 프로그램은 일회성이었지만, IOStream을 사용하면 데이터베이스처럼 사용할 수 있다. 또한, 기존 파일들을 이용하여 프로그래밍을 할 수 있다. 프로그래밍을 다채롭게 할 수 있는 IOStream을 알아보도록 하자.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
# IO Stream
> IOStream을 사용하려면 다음 항목을 추가해야 한다.
> import java.io.*;

Java는 Input, Output과 관련된 IOStream API를 제공한다.
읽기와 쓰기를 동시에 할 수 없으며, **단방향 스트림**이다.

처리를 할 때 여러가지 방법이 있는데 다음과 같다.

**<byte단위로 처리>**
byte는 영어의 경우 1byte를 차지, 한글의 경우는 2byte를 차지하며, 이와 같은 방식으로 읽어내는 것을 의미한다. *(파일 전송, 동영상, 이미지 파일 등의 처리)*
- byte단위로 읽기 - InputStream
- byte단위로 쓰기 - OutputStream

**<문자단위로 처리>**
영어와 한글 상관 없이 하나의 문자로 처리한다는 것을 의미한다. *(채팅프로그램 등)*
- 문자단위로 읽기 - Reader
- 문자단위로 쓰기 - Writer

용어 정리
- 노드 Stream - 읽기, 쓰기를 바로 할 수 있는 것. 반드시 필요함.
- 필터(보조) Stream - 중간에 읽기 또는 쓰기를 보조stream에 넣어 가공하는 역할. 없어도 읽기, 쓰기 가능 ex) 입출력향상에 도움을 주는 Buffered사용 / byte단위 -> 문자단위로 OR 문자단위 -> byte단위로 변환

## File
<읽기 메소드>
> ~.read()

InputStream과 Reader의 각 read()메소드는 같은 의미가 아니다.
[Java Platform SE 8](https://docs.oracle.com/javase/8/docs/api/) 사이트에서 찾아보면 각각 해당하는 의미를 찾아볼 수 있다.

<쓰기 메소드>
> ~.write()

OutputStream과 Writer의 각 write()메소드는 같은 의미가 아니다.

File에 대한 IO 코딩 순서는 다음과 같다.
절대적인 것은 아니지만, 나름의 틀과 순서를 지키는 것이 **프로그램의 규모가 커짐**에 따라 빛을 발할 수 있다.
```java
try {
	1) 생성
	2) 읽기 또는 쓰기
} catch () {

} finally {
	3) 닫기
}
```
하지만 위의 순서를 지키려고 하면 다음과 같은 오류가 발생할 수 있다.
```java
	public FileInputStreamExam() {
		try {
			FileInputStream fis = new FileInputStream("src/ex0218/io/test.txt");
		} catch (Exception e) {
			
		} finally {
			fis.close(); // 오류 발생! fis가 지역 변수임
		}
	}
```
> "src/ex0218/io/text.txt"// 필자는 eclipse를 사용하기 때문에 **현재 실행 중인 패키지**가 기반이 된다.
> 이것은 각자가 파일 경로를 새롭게 설정해주어야 한다.

fis는 try 내부에서 선언된 지역변수이며, 따라서 finally에서 사용할 수 없는 것이다.
사용하기 위해서는 밖으로 빼내는 작업이 필요한 것이다.
그러면 다음 코드로 변환을 해보자.
```java
		FileInputStream fis = null;
		try {
			fis = new FileInputStream("src/ex0218/io/test.txt");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				fis.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
```
그랬더니 코드가 정말 지저분해 보인다.
fis.close()는 try구문 안에 있어야 Exception으로 catch가 가능하기 때문에 무조건 try내부에 있어야 한다.
그러다 보니 finally 안에서 또 다른 try 구문이 발생하고, 점차 코드는 길어져만 간다.
그래서 나온 문법이다. 다음 코드를 보자.
```java
	public FileInputStreamExam() {
		try (FileInputStream fis = new FileInputStream("src/ex0218/io/test.txt")){

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
	}
```
이는 자동으로 try구문이 끝나게 되면 **'자동 리소스 닫기'** 기능이 실행된다.
도중에 예외가 발생이 될 때 자동으로 close()메소드가 호출이 되어 **close()가 실행된 이후** catch블록이 실행이 되는 것이다.

## File 여러가지 예제
먼저 InputStream에 대한 예제를 확인한 후에 OutputStream을 사용해보기로 한다.

### FileExam.java
```java
public class FileExam {
	public FileExam() throws IOException {
		String fileName = JOptionPane.showInputDialog("파일 이름은?");
		File file = new File(fileName);
		if(file.isDirectory()) { //fileName에 해당하는 것이 폴더라면 폴더리스트 출력
			System.out.println("=======" + fileName + "폴더 정보=======");
			String fnames [] = file.list();
			for(String name : fnames) {
				System.out.println(name);
			}
		} else { //fileName에 해당하는 것이 파일이면 파일에 대한 정보들을 출력
			System.out.println("=======" + fileName + "파일 정보=======");
			System.out.println("읽기기능 = " + file.canRead());
			System.out.println("쓰기기능 = " + file.canWrite());
			System.out.println("파일이름 = " + file.getName());
			System.out.println("절대경로 = " + file.getAbsolutePath());
			System.out.println("파일크기 = " + file.length());
			System.out.println("마지막 수정일 = " + file.lastModified());
			
			System.out.println(new Date(file.lastModified()).toLocaleString());
		}
	}
	public static void main(String[] args) throws IOException{
		new FileExam();
	}
}
```
```java
//결과화면
=======src\ex0218\io\newTextFile.txt파일 정보=======
읽기기능 = true
쓰기기능 = true
파일이름 = newTextFile.txt
절대경로 = C:\Users\oueya\Desktop\java\JavaWorkspace\step07_IOExam\src\ex0218\io\newTextFile.txt
파일크기 = 18
마지막 수정일 = 1613625682148
2021. 2. 18. 오후 2:21:22
```

### FileInputStreamExam.java
```java
public class FileInputStreamExam {
	public FileInputStreamExam() {
		try (FileInputStream fis = new FileInputStream("src/ex0218/io/test.txt")){
			int size = fis.available(); // test.txt에 있는 사용한 공간 알아내어서
			byte b [] = new byte[size]; //byte의 크기 배열만큼 저장
			fis.read(b); //b를 이용하여 fis 객체에 읽어들이고
			String name = new String(b); //String에서는 바이트를 읽을 수 있도록 String으로 변환하는 기능을 제공한다.
			System.out.println(name); //그 String에 담긴 내용을 출력
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
	}
	
	public static void main(String[] args) {
		new FileInputStreamExam();
	}
}
```

### FileCopyExam.java
```java
public class FileCopyExam {
	public FileCopyExam(String r, String w) {
		FileInputStream fis = null;
		FileOutputStream fos = null;
		try {
			fis = new FileInputStream(r);
			fos = new FileOutputStream(w);
			
			int size = fis.available();
			byte [] d = new byte[size];
			fis.read(d);
			
			//String data = new String(d);
			fos.write(d);
		} catch(Exception e) {

		} finally {
			try {
				fis.close();
				fos.close();
			} catch (Exception e) {
				
			}
		}
	}
	
	public static void main(String[] args) {
		String readFile = JOptionPane.showInputDialog("읽을 파일 명");
		String writeFile = JOptionPane.showInputDialog("저장할 파일명");
		new FileCopyExam(readFile, writeFile);
	}
}

```
항상 메소드나 알아야 하는 클래스가 존재한다면 api docs를 무조건 참고하는 편이다.
꼭 참고하도록 하자.

## 보조Stream
아까 정리했던 byte단위 Stream과 문자 단위 Stream을 정리했었다.
보조Stream은 다음과 같이 바뀐다.

**<byte단위로 처리>**
- byte단위로 읽기 - InputStream -> BufferedInputStream
- byte단위로 쓰기 - OutputStream -> BufferedOutputStream 

**<문자단위로 처리>**
- 문자단위로 읽기 - Reader -> BufferedReader
- 문자단위로 쓰기 - Writer -> BufferedWriter

그래서 위에서 그저 사용했었던 FileInputStream을 BufferedInputStream으로 바꾸어 줌으로써
속도로 이득을 볼 수 있다.
```java
public class FileCopyBufferedExam {
	public FileCopyBufferedExam(String r, String w) {
		BufferedInputStream fis = null;
		BufferedOutputStream fos = null;
		try {
			fis = new BufferedInputStream(new FileInputStream(r));
			fos = new BufferedOutputStream(new FileOutputStream(w));
			
			int i = 0;
			while((i = fis.read()) != -1) {
				fos.write(i);
			}
		} catch(Exception e) {

		} finally {
			try {
				fis.close();
				fos.close();
			} catch (Exception e) {
				
			}
		}
	}
	
	public static void main(String[] args) {
		String readFile = JOptionPane.showInputDialog("읽을 파일 명");
		String writeFile = JOptionPane.showInputDialog("저장할 파일명");
		
		long startTime;
		long endTime;
		
		startTime = System.nanoTime();
		new FileCopyBufferedExam(readFile, writeFile);
		endTime = System.nanoTime();
		System.out.println(endTime - startTime);
	}
}
```

Buffered으로 바꾸었더니 700KB정도 되는 사진을 복사했을 때 무려
4105883900 - 39798600 = 4066085300 즉, **4.0660853초 차이**가 발생했다.

700KB밖에 안되어도 복사하고 붙여 넣는데 4초의 시간 차이가 발생한다.

## 키보드 입력
키보드 입력은 기본적으로 InputStream이기 때문에
Reader으로 변환하는 과정이 필요로 하다.
그때 사용하는 것이 보조Stream이며 **InputStreamReader을 사용**하면 된다.