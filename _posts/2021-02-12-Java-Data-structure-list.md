---
date: 2021-02-12 11:23:40
layout: post
title: Java Data structure List
description: Java에서는 자료 구조 컬렉션을 제공해준다. 어떤 컬렉션이 있는지 살펴 보고, 각각의 특징을 보도록 한다.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
# List

List 컬렉션은 객체를 일렬로 늘어놓은 구조이다.
**객체를 인덱스로 관리하며, 객체 자체를 저장하는 것이 아닌, 객체의 번지를 참조한다**

ArrayList, Vector, LinkedList가 있으며, 각각 정의할 때에는
`ArrayList<String> list = new ArrayList<String>(5);` 의 형태보다는
`List<String> list = new ArrayList<String>(5);` 의 형태를 선호한다.

**List**란 각 구현 클래스의 틀을 정하는 **interface**로 정의되어 있으며
사용자의 편의로 인해, 또는 어떤 기업의 요구에 맞게 ArrayList에서 속도가 좀더 빠른 LinkedList로 변환하기를 요구할 수 있다.

즉, 새로운 상황이나 유지 보수 측면에서는 List로 선언하는 것이 다른 변화에 위험 부담이 적다는 뜻이다.

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

그러나 Java는 오토박싱을 지원한다. 즉, `Integer int = new Integer();` 과정을 거치지 않아도, 인수로 받은 i 가 **자동으로 Integer Boxing**이 되어 저장된다는 것이다.

> Integer it =  new ~~Integer~~(i) 와 같은 모습이 보인다면,
> `Integer it =  Integer.valueOf(i)` 으로 교체해주길 바란다.
> 이는 version 9 이후에 새로운 문법에서 추천하지 않는 구문이기 때문이다.

## Vector
Vector는 ArrayList와 동일한 구조를 취하고 있기 때문에 어렵지 않다. 또한 생성하는 방법도 같기 때문에 상위 인터페이스인 List를 객체에 취함으로써 생성하는 것이 효율적이다.
`List<E> list = new Vector<E>();`

Vector는 ArrayList와 차이점은 **동기화된 메소드로 구성**되어 있는가, 아닌가 이다. Vector는 동기화된 메소드로 구성되어 있기 때문에 하나의 스레드가 실행을 완료해야만 다른 스레드를 실행할 수 있다.

간단히 정리하자면, ArrayList는 동기화가 되어있지 않아 속도 면에서 우월하지만, Vector는 속도가 조금 느린 대신에 스레드가 안전하다고 볼 수 있는 것이다.

ArrayList와 Vector는 각각 포함하고 있는 **상속과 인터페이스**가 같기 때문에,
큰 차이 없이 메소드를 이용하면 된다.
### ArrayList
![20210215103838](https://user-images.githubusercontent.com/68142821/107896593-0ecde580-6f7a-11eb-9496-bee75981d6d4.png)

### Vector
![20210215103851](https://user-images.githubusercontent.com/68142821/107896595-0f667c00-6f7a-11eb-956f-dd9aa459a60a.png)

## LinkedList
ArrayList와 Vector 모두 같은 인터페이스를 상속 받았기에 사용하는 방법이 매우 유사하였다.
하지만 그 둘이 내부 배열에 객체를 저장하여 인덱스로 관리하였다고 하면
LinkedList는 **인접 참조를 링크**하는 방식이다.

> 다음 사진을 보면 Deque라는 인터페이스가 추가로 있는 것이 보인다.
![20210215105310](https://user-images.githubusercontent.com/68142821/107897263-fe1e6f00-6f7b-11eb-896b-aeea0f20d89d.png)


ArrayList와 Vector에서는 하나의 인덱스를 제거하면, 그 뒤에 있는 모든 요소들이 한 칸씩 앞으로 자리하게되는 구조였다.

즉, 객체를 빈번하게 제거하고, 추가하는 작업에서의 ArrayList는 **속도가 느려질 수** 밖에 없다.

그러나 LinkedList는 수정이 일어나는 곳 **앞, 뒤**에서 link하는 객체를 바꾸기만 하면 되기 때문에 객체의 삽입, 수정, 삭제의 요청에 효율적으로 응할 수 있다.
<img  src = "https://user-images.githubusercontent.com/68142821/107897840-8cdfbb80-6f7d-11eb-863f-1005bc779467.jpg"  width="60%">  

다음은 ArrayList와 LinkedList의 속도 차이를 보자.
```java
import java.util.*;
public class LinkedListExample {
	public static void main(String[] args) {
		List<String> list1 = new ArrayList<String>();
		List<String> list2 = new LinkedList<String>();
	
		long startTime;
		long endTime;
		
		//임의의 고정된 구간에서 nano seconds의 값을 반환합니다.
		//자바 버전 **1.5 이상**
		startTime = System.nanoTime();
		for(int i = 0; i < 10000; i++) { //0번지에 지속적으로 추가하여 객체가 뒤로 밀려나게 합니다.
			list1.add(0, String.valueOf(i));
		}
		
		//nano seconds 끝
		endTime = System.nanoTime();
		System.out.println("ArrayList 걸린시간: " + (endTime-startTime) + " ns");
		
		startTime = System.nanoTime();
		for(int i = 0; i < 10000; i++) {
			list2.add(0, String.valueOf(i));
		}
		endTime = System.nanoTime();
		System.out.println("LinkedList 걸린시간: " + (endTime-startTime) + " ns");
	}
}
```

다음은 결과이다.
```java
ArrayList 걸린시간: 12056400 ns
LinkedList 걸린시간: 4505500 ns
```

고정 값은 아니지만, 이 실험으로 객체의 삽입에는 LinkedList가 속도가 빠르다는 것을 알 수 있다.
지금은 0번지에 계속 객체를 삽입하여 ArrayList측에서는 객체가 계속 뒤로 밀려나게 했지만,
순차적으로 추가하거나 삭제하는 부분에서는 LinkedList보다 ArrayList가 더 빠를 것이다.

**중요한 점은 어떤 상황에서 어느 컬렉션이 더 나을 것인가를 생각해보고, 구현하는 것이 올바른 선택이라는 것이다.**