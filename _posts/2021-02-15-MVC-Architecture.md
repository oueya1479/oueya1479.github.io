---
date: 2021-02-15 14:24:42
layout: post
title: MVC Architecture
description: Java를 통해 MVC구조를 연습해보고, 이전 시간에 배운 Map을 활용하여 더욱 풍부한 문법을 연습해본다.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
# Main
MVC구조는 Main을 담당하고 있는 StartView와
Controller를 담당하고 있는 MapStudentController,
Service를 담당하고 있는 MapStudentService 파일이 있으며

객체의 정보를 저장할 수 있는 Person과 그를 상속하고 있는 Student로 나누었다.
또한, 사용자에게 보여주는 모든 출력은 EndView에서 담당한다.
## StartView.java
```java
package map_project;

public class StartView {

	public static void main(String[] args) {
		//MVC구조형태 : startView -> controller -> service 
		//1. 전체검색
		MapStudentController.selectAll();
		
		System.out.println();
		
		System.out.println("2.검색하기(Person인경우) ******************");
		MapStudentController.searchById("jang"); //결과 : 이름
		System.out.println();

		System.out.println("2.검색하기(Student인경우) ******************");
		MapStudentController.searchById("king"); //결과 : 이름, 총점
		System.out.println();

		System.out.println("2.검색하기(없는경우) ******************");
		MapStudentController.searchById("test"); //결과 : 예외메시지
		
		System.out.println();
		
		System.out.println("3.등록하기(Person) ******************");
		MapStudentController.insert(new Person("bbb", "시스타", 20));
		System.out.println();

		System.out.println("3.등록하기(Student) ******************");
		MapStudentController.insert(new Student("ccc", "빅뱅", 25, 80, 80, 80));
		System.out.println();

		System.out.println("3.등록하기(id 중복= key 중복) ******************");
		MapStudentController.insert(new Person("jang", "이쁜이", 30));
		System.out.println();

		
		MapStudentController.selectAll();
        System.out.println();
		
		System.out.println("4.삭제하기(성공) ******************");
		MapStudentController.delete("kim");
		System.out.println();

		System.out.println("4.삭제하기(실패) ******************");
		MapStudentController.delete("qqq");
		System.out.println();

		MapStudentController.selectAll();
		System.out.println();
		
		System.out.println("4.수정하기(Person) ******************");
		MapStudentController.update(new Person("jang","이쁘이"));// id와 name만 전달- 생성자추가 
		System.out.println();

		MapStudentController.selectAll();
		System.out.println();

		System.out.println("4.수정하기(Student) ******************");
		MapStudentController.update(new Student("jang","얼짱" , 40, 50, 50)); //-생성자 추가
		//-> 실제 map에 저장된 jang은 Person타입 ,근데
		//   수정하려고 Student 넣으면 안된다..a--이부분에 대한 오류를 안했다
		System.out.println();

		MapStudentController.selectAll();
		System.out.println();

		MapStudentController.update(new Student("king","왕자" , 40,50,50)); //-생성자 추가
		MapStudentController.selectAll();
		System.out.println();
	}
}
```

StartView에서는 원래 사용자로부터 입력을 계속 받아 진행해야 하지만,
실습이라 고정된 값으로 진행했다.

## Person.java
```java
package map_project;

public class Person {
	private String id;
	private String name;
	private int age;
	
	public Person() {}
	
	public Person(String id, String name) {
		super();
		this.id = id;
		this.name = name;
	}
	
	public Person(String id, String name, int age) {
		this(id, name);
		this.age = age;
	}
	
	public String getId() { return id; }
	public void setId(String id) { this.id = id; }
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public int getAge() { return age; }
	public void setAge(int age) { this.age = age; }
	
	@Override
	public String toString() {
		return "Person [id=" + id + ", name=" + name + ", age=" + age + "]";
	}
}
```

## Student.java
```java
package map_project;

public class Student extends Person {
	private int kor;
	private int eng;
	private int math;
	private int sum;
	
	public Student() {}
	
	public Student(String id, String name, int kor, int eng, int math) {
		super(id, name);
		this.kor = kor;
		this.eng = eng;
		this.math = math;
		
		this.sum = kor + eng + math;
	}
	
	public Student(String id, String name, int age, int kor, int eng, int math) {
		this(id, name, kor, eng, math);
		setAge(age);
	}

	public int getKor() { return kor; }
	public void setKor(int kor) { this.kor = kor; }
	public int getEng() { return eng; }
	public void setEng(int eng) {this.eng = eng; }
	public int getMath() { return math; }
	public void setMath( int math) {this.math = math; }
	public int getSum() { return sum; }
	public void setSum(int sum) { this.sum = sum; }

	@Override
	public String toString() {
		return "Student [kor=" + kor + ", eng=" + eng + ", math=" + math + ", sum=" + sum + "]";
	}
}
```

## MapStudentController.java
```java
package map_project;

public class MapStudentController {
	static MapStudentService service = new MapStudentService();
	
	public MapStudentController() {
		
	}
	
	public static void selectAll() {
		EndView.printAll(service.selectAll());
	}
	
	public static void searchById(String key) {
		Person person = service.searchByKey(key);
		if(person != null) {
			EndView.printSearch(person);
		} else {
			EndView.printMessage("해당하는 아이디가 없습니다.");
		}
	}
	
	public static void insert(Person person) {
		try {
			service.insert(person);
			EndView.printMessage("정상적으로 등록되었습니다.");
		} catch (RuntimeException e) {
			EndView.printMessage("등록되지 않았습니다.");
		}
	}
	
	public static void delete(String key) {
		try {
			service.delete(key);
			EndView.printMessage("정상적으로 삭제되었습니다.");
		} catch (RuntimeException e) {
			EndView.printMessage("삭제되지 않았습니다.");
		}
	}
	
	public static void update(Person person) {
		try {
			service.update(person);
			EndView.printMessage("정상적으로 수정되었습니다.");
		} catch(RuntimeException e) {
			EndView.printMessage("수정되지 않았습니다.");
		}
	}
}
```

## MapStudentService.java
```java
package map_project;

import java.util.HashMap;
import java.util.Map;

public class MapStudentService {
	private Map<String, Person> map = new HashMap<String, Person>();
	public MapStudentService() {
		map.put("kim", this.create("kim", "김동헌", 24, 90, 87, 96));
		map.put("lee", this.create("lee", "이영표", 50));
		map.put("jang", this.create("jang", "장사꾼", 42));
		map.put("king", this.create("king", "박지성", 30, 78, 85, 48));
		map.put("choi", this.create("choi", "최정", 35));
	}
	
	/**
	 * map에 저장할 객체를 생성해서 리턴해주는 메소드
	 */
	public Person create(String id, String name, int age, int ...params) {
		if(params.length == 0) {
			return new Person(id, name, age);
		} else if(params.length == 3) { 
			return new Student(id, name, age, params[0], params[1], params[2]);
		} else {
			throw new RuntimeException("전달된 인수가 잘못되어 생성할 수 없습니다.");
		}
	}
	
	/**
	 * 전체 검색
	 */
	public Map<String, Person> selectAll() {
		return map;
	}

	/**
	 * key에 해당하는 정보 검색
	 *   :key해당하는 정보를 출력할때 
	 *    [ Person인경우는 이름만 출력
	 *     Student인경우는 이름과 총점 출력 ] -> EndView에서 
	 *     없는경우는 "id는 없습니다." 예외발생
	 * */
	public Person searchByKey(String key) {
		if(map.containsKey(key)) {
			Person person = map.get(key);
			return person;
		} else {
			return null;
		}
	}
	
	/**
	 * 등록 : key와 Person의 정보를 받아 등록하는 메소드
	 *        등록이 실패하면(id중복체크!!) 예외발생시킨다.("등록되지 않았습니다.")
	 * */
	public void insert(Person person) {
		if(map.containsKey(person.getId())) {
			throw new RuntimeException();
		}
		map.put(person.getId(), person);
	}


	/**
	 *  삭제
	 *   : id에 해당하는 value가 삭제되지 않으면 예외발생
	 *      (삭제되지 않았습니다.)
	 * */
	public void delete(String key) {
		if(!map.containsKey(key)) {
			throw new RuntimeException();
		}
		map.remove(key);
	}

	/**
	 * 수정
	 *   만약, Person인경우 - 이름만 수정
	 *         Student인경우  - 이름, 국어 ,영어,수학수정(총점 변경)
	 *    수정이 안된다면 예외발생
	 *    인수로 전달된 객체타입과 key에 해당하는 객체 타입이 일치할 때
	 *    수정해야 한다. 만약 인수는 Student인데 key의 찾은 객체가 Person이라면
	 *    수정하면 안 된다.
	 * */
	public void update(Person person) {
		if(!map.get(person.getId()).getClass().getName().equals(person.getClass().getName())) {
			throw new RuntimeException();
		}
		if(person instanceof Student) {
			Student student = (Student) person;
			map.put(person.getId(), student);
		} else {
			map.put(person.getId(), person);
		}
	}
}
```

## EndView.java
```java
package map_project;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class EndView {
	public EndView() { }
	
	public static void printAll(Map<String, Person> map) {
		Set<String> set = map.keySet();
		Iterator<String> it = set.iterator();
		while(it.hasNext()) {
			String key = it.next();
			Person value = map.get(key);
			System.out.println(key + " : " + value);
		}
	}
	
	public static void printSearch(Person person) {
		if(person instanceof Student) {
			Student student = (Student) person;
			System.out.println("이름 : " + student.getName() + ", 총점 : " + student.getSum());
		} else {
			System.out.println("이름 : " + person.getName());
		}
	}

	public static void printMessage(String message) {
		System.out.println(message);
	}
}
```

## 느낀점
생각보다 MVC구조를 갖추는 것이 어려웠기도 하고, 왜 하는지 의문이었는데
점차 규모가 커짐에 따라 구조를 갖추고 있는 것이 프로젝트를 이해하는데 더 쉬워 보였다.

결국 규모가 작은 프로그램을 돌리기에는 막무가내로 만들어도 어느 정도 커버가 가능하지만,
규모가 큰 프로그램을 돌리기 위해서는 형식을 갖추어야 한다는 것이다.

이번 Map을 활용한 MVC는 나름 성공적이었다. 각각의 기능을 throw를 통하여 예외 처리를 발생시키기도 하였고, 메소드의 인자 값과 return 등 나름의 자리와 규칙을 서술할 수 있었다. 이후에는 사용자 정의 예외를 만들어 상황에 따른 예외도 발생 시켜 보아야겠다.