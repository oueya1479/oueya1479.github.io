---
date: 2021-02-13 15:03:06
layout: post
title: Java Data structure Map
description: Java에서는 자료 구조 컬렉션을 제공해준다. 어떤 컬렉션이 있는지 살펴 보고, 각각의 특징을 보도록 한다.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
# Map
List와 Set은 하나의 **공간**에 하나의 **값**이 들어간 것이라고 인식할 수 있다.
Map은 하나의 공간에 **두 개의 값**이 들어간 것이라고 생각하면 편하다.

물론 정확히 말하자면, key값과 value값으로 구성된 객체를 저장하는 구조를 가지고 있다.

지금껏 List<**E**>, Set<**E**> 이라고 표현해왔고, E는 **the type of elements maintained by this set**를 의미했다.

Map에서는 Map<**K**, **V**>과 같은 방법으로 표기를 하는데
K는 **the type of keys maintained by this map**,
V는 **the type of mapped values**를 의미하는 것이다.

~~그냥 Key, Value라고 외우면 편하다~~

## Hash Map
다음 예시를 보고 Map이 어떤 역할을 하는지 빠르게 이해해보자.
```java
public class MapExam extends HashMap<Integer, String>{
	public MapExam() {
		put(10, "동원");
		put(30, "동투");
		put(20, "동쓰리");
		put(10, "동포");
		put(40, "동파이브");
		put(30, "동식스");
		
		System.out.println("추가 후 : " + this);
	}
	
	public static void main(String[] args) {
		new MapExam();
	}
}
```

HashMap을 상속받았기 때문에 super.put 메소드를 사용할 수 있으며,
List에서 사용한 add와 비슷한 개념으로 생각하면 된다.
```java
	//결과
	추가 후 : {20=동쓰리, 40=동파이브, 10=동포, 30=동식스}
```

`put(10,  "동원");`  `put(30,  "동투");`가 먼저 실행되었음에도 '**동쓰리**'가 먼저 출력되었다.
이는 Set과 동일하게 **값의 중복을 피하는** 결과를 나타냈지만, 다른 시선으로 보면 **중복 값을 삽입하게 되면 원래 있던 값은 사라지고, 새로운 값으로 저장**이 되는 결과를 보여주었다.

## TreeMap
HashMap과 TreeMap의 가장 큰 차이는 TreeMap은 **정렬**이 된다는 것이다!
이참에 제거하는 방법까지 알아본다.
```java
public class MapExam extends TreeMap<Integer, String>{
	public MapExam() {
		put(10, "동원");
		put(30, "동투");
		put(20, "동쓰리");
		put(10, "동포");
		put(40, "동파이브");
		put(30, "동식스");
		
		System.out.println("추가 후 : " + this);
		String value = super.remove(30);
		System.out.println("제거된 객체 : " + value);
		System.out.println("제거 후 : " + this);
	}
	
	public static void main(String[] args) {
		new MapExam();
	}
}
```

```java
추가 후 : {10=동포, 20=동쓰리, 30=동식스, 40=동파이브}
제거된 객체 : 동식스
제거 후 : {10=동포, 20=동쓰리, 40=동파이브}
```

## Iterator
Set에서 배웠던 방법으로 Iterator를 사용하여 하나씩 꺼내는 연습을 해본다.
```java
public class MapExam extends TreeMap<Integer, String>{
	public MapExam() {
		put(10, "동원");
		put(30, "동투");
		put(20, "동쓰리");
		put(10, "동포");
		put(40, "동파이브");
		put(30, "동식스");
		
		System.out.println("추가 후 : " + this);
		String value = super.remove(30);
		System.out.println("제거된 객체 : " + value);
		System.out.println("제거 후 : " + this);
		
		//Iterator
		Set<Integer> set = super.keySet();
		Iterator<Integer> it = set.iterator();
		while(it.hasNext()) {
			int k = it.next();
			String v = super.get(k);
			System.out.println(k + " : " + v);
		}
	}
	
	public static void main(String[] args) {
		new MapExam();
	}
}
```

Iterator구문은 개선된 for문으로 변환할 수 있다.
```java
for(Integer k : super.keySet()) {
	String v = super.get(key);
	System.out.println(k + " : " + v);
}
```

다음과 같은 방법도 있다.

Set에 Map의 Key와 Value가 담긴 하나의 Entry를 entrySet() 메소드를 통해 담는 것이다.
위의 Iterator방법과 동일하지만 Integer대신에 Map.Entry<Integer, String>을 통하여 담는 방법으로,
조금 복잡해 보이기는 한다.
```java
Set<Map.Entry<Integer, String>> entrySet = super.entrySet();
Iterator<Map.Entry<Integer, String>> entryIt = entrySet.iterator();
while(entryIt.hasNext()) {
	Map.Entry<Integer, String> entry = entryIt.next();
	int k = entry.getKey();
	String v = entry.getValue();
	System.out.println(k + " : " + v);
}
```

위의 방법에도 개선된 for 구문으로 조금 쉽게 가능하다.
```java
for(Map.Entry<Integer, String> e : super.entrySet()) {
	Integer k = e.getKey();
	String v = e.getValue();
	system.out.println(k + " : " + v);
}
```