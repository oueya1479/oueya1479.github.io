---
date: 2021-02-19 15:32:44
layout: post
title: Java Object save
description: empty
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->

# 데이터 저장
1. 변수 : 한 타입에 한 개의 값만 저장
2. 배열 : 한 타입으로 여러 개의 값 저장, 데이터 조작(등록, 검색, 수정, 삭제)의 불편함
3. 자료구조 : 다양한 타입을 여러 개 저장할 수 있고, 데이터 조작 또한 편리함

이는 영속성에 한계가 있다. 프로그램이 종료되면 초기화되어 사라진다는 의미이다.
그래서 일회성이 아닌 계속 이어가는 프로그램을 제작하고 싶으면 **데이터를 저장**하는 것을 필요로 한다.

이전 post에서 IOStream을 통하여 파일에 저장하고 불러오는 기능을 실습 해보았다.
간단하게 전체 내용을 읽어오거나, 전체 내용을 바꾸는 기능 만을 실습 했는데
**이는 방대한 데이터를 저장해서 필요한 정보를 꺼내는데 어려움이 있다**는 것이다.

결론은 파일에 저장하는 방법과 꺼내오는 방법의 새로운 관점으로 다가가야 한다.
이름, 나이, 주소, 연락처 등 자바에서는 **객체**로 관리하고 있다. 예를 들어 Student클래스를 만드는 것 처럼.
Student라는 객체를 파일에 저장하고, 그 객체를 **직렬화(byte코드로 변환해서 저장)** 를 해서 저장한다.
> : ObjectOutputStream : 객체를 직렬화 해서 저장
> ex) writeObject(Object obj)
> : ObjectInputStream : 객체를 역직렬화 해서 읽기
>ex) Object obj = ois.readObject();

다음 코드를 보고 간단하게 이해해보자.
### Student
```java
public class Student implements Serializable{
	private String name;
	private int age;
	private transient String addr; //transient키워드를 사용하면 직렬화가 되지 않는다!
	
	public Student() {}
	public Student(String name, int age, String addr) {
		super();
		this.name = name;
		this.age = age;
		this.addr = addr;
	}
}
```
### ObjectSaveExam.java
```java
public class ObjectSaveExam {
	public ObjectSaveExam() {
		Student st1 = new Student("일일", 24, "성남"); //그냥 집어넣기 위한 객체
		Student st2 = new Student("이이", 28, "광주");
	
		List<Student> list = new ArrayList<Student>(); //리스트로 한 번에 집어넣기 위한 객체
		list.add(new Student("삼삼", 54, "분당"));
		list.add(new Student("사사", 59, "여주"));
		list.add(new Student("오오", 80, "양양"));
		
		//객체를 파일에 저장하고 읽어오는 방법은 byte단위에서만 가능하다.
		//사실 파일경로를 그대로 노출하는 것은, 사람마다 환경이 달라 조심스럽지만,
		//각자가 파일 경로명은 잘 설정하기를 기대한다.
		//필자는 eclipse를 사용하여 패키지를 사용하는 현재 디렉토리로부터 시작하여 src로 들어간다.
		try (ObjectOutputStream oos = 
				new ObjectOutputStream(new FileOutputStream("src/ex0219/io/save.txt"))) 
		{
			oos.writeObject(st1); //writeObject를 사용하기 위해서는 ObjectOutputStream클래스를 사용해야 한다.
			oos.writeObject(st2);
			oos.writeObject(list);
			System.out.println("저장 완료. 파일을 확인하세요!");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		new ObjectSaveExam();
	}
}
```

### ObjectLoadExam.java
```java
public class ObjectLoadExam {
	public ObjectLoadExam() {
		try (ObjectInputStream ois = 
				new ObjectInputStream(new FileInputStream("src/ex0219/io/save.txt"))) 
		{
			Student s1 = (Student)ois.readObject();
			Student s2 = (Student)ois.readObject();
			List<Student> list = (List<Student>)ois.readObject();
			
			System.out.println(s1);
			System.out.println(s2);
			System.out.println(list);

		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		new ObjectLoadExam();
	}
}
```
### 결과
```java
일일 | 24 | null // null이 출력된 이유는 addr변수에 transient키워드를 사용했기 때문이다!
이이 | 28 | null
[삼삼 | 54 | null, 사사 | 59 | null, 오오 | 80 | null]
```