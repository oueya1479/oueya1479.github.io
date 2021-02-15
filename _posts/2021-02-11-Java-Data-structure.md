---
date: 2021-02-11 10:42:35
layout: post
title: Java Data structure
description: Java에서는 자료 구조 컬렉션을 제공해준다. 어떤 컬렉션이 있는지 살펴 보고, 각각의 특징을 보도록 한다.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
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

> 배열의 한계 : 
컴파일 하기 전 배열의 길이를 지정.
길이가 정해지면 바뀌지 않음.
**다양한 데이터 타입의 저장이 불가능하다.**

```java
		String[] array = new String[10];
		array[0] = new String();
``` 

## 자료구조의 장점
자료구조에서는 **다양한 데이터 타입의 저장**이 가능하다. 설명을 덧붙이자면,
자료구조에 기본형을 그냥 저장할 수 없기 때문에 Wrapper클래스를 이용하게 되며,
autoBoxingm, unBoxing 개념이 적용되면 Wrapper클래스 없이도 자동으로 변환해준다.

또한, **다양한 데이터들을 저장, 조회, 수정, 제거 기능을 제공**한다는 점이다.
배열로 구성했을 때는 하나 하나의 메소드를 직접 구현해야 했다.

![array_list_method](https://user-images.githubusercontent.com/68142821/107457428-6395e880-6b95-11eb-9a79-b86d400db6e1.png)
*출처 : https://docs.oracle.com/javase/8/docs/api/*

여기서 헷갈릴 수도 있으니 다시 한 번 overload와 override의 설명을 짚고 넘어가자.
>Overload : 
반드시 하나의 클래스내에 이름이 같은 것이 여러 개 존재하는 것
사용자 입장에서는 하나의 메소드를 사용하지만,
호출될 때 전달되는 매개변수에 따라 다른 메소드를 호출

>Override : 
반드시 상속관계일 때 부모에 있는 메소드를 자식 클래스 내에 동일하게 만드는 것
부모의 있는 메소드의 기능이 마음에 들지 않아 다른 일을 하고 싶을 때
메소드를 Override를 하여 다른 기능을 구현함

## 컬렉션 프레임워크의 인터페이스

다음은 내가 참고하고 있는 책인 「이것이 자바다」 라는 책에서 컬렉션 프레임워크를
설명한 것이다.
![image1](https://user-images.githubusercontent.com/68142821/107894814-49348400-6f74-11eb-8582-f1afbe062d1b.jpg)

위의 사진에서 화살표의 모습은 다음 사진을 보도록 하자.
![image2](https://user-images.githubusercontent.com/68142821/107894842-65d0bc00-6f74-11eb-80c5-bbe12374c7b6.jpg)