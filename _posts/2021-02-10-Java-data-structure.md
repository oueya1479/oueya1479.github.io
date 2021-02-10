---
date: 2021-02-10T09:43:05.000Z
layout: post
title: Java data structure
subtitle: '컬렉션 프레임워크'
description: Java에서는 자료 구조 컬렉션을 제공해준다. 어떤 컬렉션이 있는지 살펴 보고, 각각의 특징을 보도록 한다.
image: https://res.cloudinary.com/dm7h7e8xj/image/upload/v1559821647/theme6_qeeojf.jpg
optimized_image: https://res.cloudinary.com/dm7h7e8xj/image/upload/c_scale,w_380/v1559821647/theme6_qeeojf.jpg
category: blog
tags:
  - programming
  - java
author: Dongheon, Kim
paginate: true
---

# 자료 구조

자료 구조는 데이터를 저장하는 구조이다.
Java에서는 이러한 구조에 해당하는 객체를 미리 만들어서 제공하며 이는 **Collection API**라고 불린다.

제공되는 interface를 살펴보도록 하자.
1. List :  순서가 있고 중복이 가능함
* ArrayList
* Vector
* LinkedList
2. Set : 순서가 없고, 중복도 되지 않음
* HashSet
* TreeSet
3. Map : key와 value의 한 쌍이며, key는 중복 불가, value는 중복 가능함
* HashMap
* HashTable
* TreeMap
* Properties

지금 까지 같은 이름으로 변수를 선언하려면 **배열**을 사용했지만, Java는 널리 알려져 있는 자료 구조를 바탕으로 객체들을 효율적으로 관리할 수 있는 컬렉션을 제공했다!

> 배열의 한계
> 컴파일 하기 전 배열의 길이를 지정.
> 길이가 정해지면 바뀌지 않음.
> **다양한 데이터 타입의 저장이 불가능하다.**

```java
		String[] array = new String[10];
		array[0] = new String();
``` 

### 자료구조의 장점
자료구조에서는 **다양한 데이터 타입의 저장**이 가능하다. 설명을 덧붙이자면,
자료구조에 기본형을 그냥 저장할 수 없기 때문에 Wrapper클래스를 이용하게 되며,
autoBoxingm, unBoxing 개념이 적용되면 Wrapper클래스 없이도 자동으로 변환해준다.

또한, **다양한 데이터들을 저장, 조회, 수정, 제거 기능을 제공**한다는 점이다.
배열로 구성했을 때는 하나 하나의 메소드를 직접 구현해야 했다.

![array_list_method](https://user-images.githubusercontent.com/68142821/107457428-6395e880-6b95-11eb-9a79-b86d400db6e1.png)
*출처 : https://docs.oracle.com/javase/8/docs/api/*

여기서 헷갈릴 수도 있으니 다시 한 번 overload와 override의 설명을 짚고 넘어가자.
>Overload
>반드시 하나의 클래스내에 이름이 같은 것이 여러 개 존재하는 것
>사용자 입장에서는 하나의 메소드를 사용하지만,
>호출될 때 전달되는 매개변수에 따라 다른 메소드를 호출

>Override
>반드시 상속관계일 때 부모에 있는 메소드를 자식 클래스 내에 동일하게 만드는 것
>부모의 있는 메소드의 기능이 마음에 들지 않아 다른 일을 하고 싶을 때
>메소드를 Override를 하여 다른 기능을 구현함

## ArrayList

일반 배열과 ArrayList는 인덱슬 객체를 관리한다는 점에서는 유사하지만,
**배열**은 생성할 때 크기가 고정되고, 사용 중에 크기를 변경할 수 없지만,
**ArrayList**는 저장 용량을 초과한 객체가 들어오면 자동적으로 용량이 늘어난다.

```java
List<String> list1 = new ArratList<String>();
//or
List<String> list2 = new ArrayList<String>(30);
```

ArrayList의 초기 생성자 저장 용량은 10이다. 생성자가 오버로딩 되어 있어 int형으로 인수를 넘겨준다면, 그 값이 **ArrayList의 저장 용량**이 된다.


이처럼 ArrayList class를 바로 사용해도 되지만, 나만의 리스트를 만들고 싶다면, ArrayList를 상속하는 class를 만들면 된다.
```java
import java.util.ArrayList;

class ArrayListExam extends ArrayList{

	Object obj;
	int i;

	//위에서 설명했듯 ArrayList는 생성자로 int가 들어오면 저장 용량이 된다.
	public ArrayListExam(){
			super(5);
	}
	
	.
	.
	.
```

메소드를 다음과 같이 만들어 보았다.
```java
	public void addInt(int i) {
		Integer it =  new Integer(i);
		add(it);
	}
		
	public void addFloat(float f) {
		Float ft = new Float(f);
		add(ft);
	}
	
	public void addString(String s) {
		add(st);
	}
	
	public void printList() {
		i = size();
		System.out.println("list에 들어있는 객체의 총 개수는 = " + i);
		for(int count = 0; count < i; count++) {
			obj = get(count);
			System.out.println(obj);
		}
	}
}
```

여기서 알아야 할 것은 add메소드는 모두 상속받고 있는 **ArrayList**에서 제공하고 있는 것이며,
super.add( .. ) 와 같은 맥락이라고 보면 된다.

`Integer it =  new  Integer(i)`의 과정이 필요한 이유는 ArrayList에는 객체만 담을 수 있기 때문에, i를 포장 객체로 만들어야만 한다. 그것을 위해 박싱(Boxing)의 과정을 거친 것이다.

> `Integer it =  new Integer(i)` 에서 노란색 밑줄이 있다면
> `Integer it =  Integer.valueOf(i)` 으로 교체해주길 바란다.
> 이는 version 9 이후에 새로운 문법에서 추천하지 않는 구문이기 때문이다.
