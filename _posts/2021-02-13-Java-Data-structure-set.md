---
date: 2021-02-13 11:33:35
layout: post
title: Java Data structure Set
description: Java에서는 자료 구조 컬렉션을 제공해준다. 어떤 컬렉션이 있는지 살펴 보고, 각각의 특징을 보도록 한다.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
# Set
이전 post에서 List에 관한 내용을 알아보았다.
List에서 알아본 ArrayList, Vector, LinkedList는 모두 하나의 공통점을 가지고 있었는데,
**저장 순서를 유지한다는 점**이다.

remove를 통해 중간 인덱스에 해당하는 객체를 지워도, 뒤에 있는 모든 객체는 앞으로 한 칸씩 앞당겨 졌고,
중간에 삽입 과정을 거쳐도, 뒤로 한 칸씩 전체적으로 밀려났다.
> 물론 LinkedList는 밀려난다는 표현보다는 중간의 Link가 달라진다는 말이 더 어울릴 것 같다.

다음은 Oracle의 docs에 있는 Java Platform SE 8 의 공식 문서이다.
Set은 어떤 메소드를 가지고 있는지 한 번 확인해보자.
![20210215115023](https://user-images.githubusercontent.com/68142821/107900332-0d091f80-6f84-11eb-85ee-b2668d4e85ac.png)
*출처 : [Oracle docs](https://docs.oracle.com/javase/8/docs/api/)*

Set의 개념을 조금 더 잘 이해해보기 위해 간단한 코드를 작성해보았다.
SetExam은 HashSet을 상속하였고, 그 클래스 자체가 Set이 되어 사용해보는 것이다.

실행하기 전 String[] args으로 인수를 넘긴 것은 다음과 같다
=> 1 2 3 4 5 **3 4 5** 6
```java
	import java.util.HashSet;

	public class SetExam extends HashSet<String> {
		public SetExam(String[] args) {
			//super(5);
			for(String s : args) {
				boolean re = super.add(s);
				System.out.println(s + "추가 결과 : " + re);
			}
			
			System.out.println("--등록결과--");
			System.out.println(this); //this는 this.toString()과 같은 의미이다.
		}
		public static void main(String[] args) {
			new SetExam(args);
		}
	}
```
```java
	1추가 결과 : true
	2추가 결과 : true
	3추가 결과 : true
	4추가 결과 : true
	5추가 결과 : true
	3추가 결과 : false
	4추가 결과 : false
	5추가 결과 : false
	6추가 결과 : true
	--등록결과--
	[1, 2, 3, 4, 5, 6]
```

Set은 중복이 되지 않는다고 했다.
그러면 다음과 같은 코드는 중복일 수 있을까?
```java
import java.util.HashSet;
import java.util.Set;

public class MemberSetExam {
	//Member라는 클래스가 하나 존재한다고 가정한다.
	Set<Member> set = new HashSet<Member>();
	
	public MemberSetExam() {
		set.add(new Member("김동헌", 24, "서울"));
		set.add(new Member("김가람", 28, "대구"));
		set.add(new Member("김동헌", 24, "서울"));
		
		System.out.println("저장된 객체 수 : " + set.size());
	}
	
	public static void main(String[] args) {
		new MemberSetExam();
	}
}
```
답은 **아니다**이다.

```java
저장된 객체 수 : 3
```

이는 객체가 각각 가지고 있는 hashCode와 equals의 메소드 기능을 살펴보아야 하는데,
Set에서 add()메소드를 통해 객체를 삽입할 때 해당 객체의 hashCode() 메소드가 실행이 되며,
같은 hashCode를 가지고 있는 객체가 존재할 경우 equals() 메소드가 실행이 된다.

이 구문이 포함이 된다고 했을 때 결과 창을 살펴보자.

```java
	@Override
	public int hashCode() {
		System.out.println("hashCode 실행");
		return name.hashCode() + age;
	}
	
	@Override
	public boolean equals(Object obj) {
		System.out.println("equals 실행");
		if(obj instanceof Member) {
			Member mb = (Member) obj;
			if(name.equals(mb.getName()) && age == mb.getAge()) {
				return true;
			}
		}
		return false;
	}
```
```java
	//결과창
	
	hashCode 실행
	hashCode 실행
	hashCode 실행
	equals 실행
	저장된 객체 수 : 2
```
## Iterator

Set컬렉션은 객체를 검색하는 메소드가 존재하지 않기 때문에 전체 객체를 대상으로 한 번씩 반복해서 가져오는 반복자 **Iterator**를 제공한다.

어떻게 사용하는지 바로 알아보도록 하자.
```java
	import java.util.HashSet;

	public class SetExam extends HashSet<String> {
		public SetExam(String[] args) {
			//super(5);
			for(String s : args) {
				boolean re = super.add(s);
				System.out.println(s + "추가 결과 : " + re);
			}
			
			System.out.println("--등록결과--");
			System.out.println(this);
			
			// 추가된 부분
			Iterator<String> it = super.iterator(); //super인 이유는 부모인 HashSet을 따르고 있기 때문이다.
			while(it.hasNext()) {
				String name = it.next();
				System.out.println(name);
			}
			// 추가된 부분
			
		}
		public static void main(String[] args) {
			new SetExam(args);
		}
	}
```
