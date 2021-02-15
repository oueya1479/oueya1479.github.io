---
date: 2021-02-15 11:33:35
layout: post
title: Java Data structure Set
description: Java������ �ڷ� ���� �÷����� �������ش�. � �÷����� �ִ��� ���� ����, ������ Ư¡�� ������ �Ѵ�.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
# Set
���� post���� List�� ���� ������ �˾ƺ��Ҵ�.
List���� �˾ƺ� ArrayList, Vector, LinkedList�� ��� �ϳ��� �������� ������ �־��µ�,
**���� ������ �����Ѵٴ� ��**�̴�.

remove�� ���� �߰� �ε����� �ش��ϴ� ��ü�� ������, �ڿ� �ִ� ��� ��ü�� ������ �� ĭ�� �մ�� ����,
�߰��� ���� ������ ���ĵ�, �ڷ� �� ĭ�� ��ü������ �з�����.
> ���� LinkedList�� �з����ٴ� ǥ�����ٴ� �߰��� Link�� �޶����ٴ� ���� �� ��︱ �� ����.

������ Oracle�� docs�� �ִ� Java Platform SE 8 �� ���� �����̴�.
Set�� � �޼ҵ带 ������ �ִ��� �� �� Ȯ���غ���.
![20210215115023](https://user-images.githubusercontent.com/68142821/107900332-0d091f80-6f84-11eb-85ee-b2668d4e85ac.png)
*��ó : [Oracle docs](https://docs.oracle.com/javase/8/docs/api/)*

Set�� ������ ���� �� �� �����غ��� ���� ������ �ڵ带 �ۼ��غ��Ҵ�.
SetExam�� HashSet�� ����Ͽ���, �� Ŭ���� ��ü�� Set�� �Ǿ� ����غ��� ���̴�.

�����ϱ� �� String[] args���� �μ��� �ѱ� ���� ������ ����
=> 1 2 3 4 5 **3 4 5** 6
```java
	import java.util.HashSet;

	public class SetExam extends HashSet<String> {
		public SetExam(String[] args) {
			//super(5);
			for(String s : args) {
				boolean re = super.add(s);
				System.out.println(s + "�߰� ��� : " + re);
			}
			
			System.out.println("--��ϰ��--");
			System.out.println(this); //this�� this.toString()�� ���� �ǹ��̴�.
		}
		public static void main(String[] args) {
			new SetExam(args);
		}
	}
```
```java
	1�߰� ��� : true
	2�߰� ��� : true
	3�߰� ��� : true
	4�߰� ��� : true
	5�߰� ��� : true
	3�߰� ��� : false
	4�߰� ��� : false
	5�߰� ��� : false
	6�߰� ��� : true
	--��ϰ��--
	[1, 2, 3, 4, 5, 6]
```

Set�� �ߺ��� ���� �ʴ´ٰ� �ߴ�.
�׷��� ������ ���� �ڵ�� �ߺ��� �� ������?
```java
import java.util.HashSet;
import java.util.Set;

public class MemberSetExam {
	//Member��� Ŭ������ �ϳ� �����Ѵٰ� �����Ѵ�.
	Set<Member> set = new HashSet<Member>();
	
	public MemberSetExam() {
		set.add(new Member("�赿��", 24, "����"));
		set.add(new Member("�谡��", 28, "�뱸"));
		set.add(new Member("�赿��", 24, "����"));
		
		System.out.println("����� ��ü �� : " + set.size());
	}
	
	public static void main(String[] args) {
		new MemberSetExam();
	}
}
```
���� **�ƴϴ�**�̴�.

```java
����� ��ü �� : 3
```


## Iterator

Set�÷����� ��ü�� �˻��ϴ� �޼ҵ尡 �������� �ʱ� ������ ��ü ��ü�� ������� �� ���� �ݺ��ؼ� �������� �ݺ��� **Iterator**�� �����Ѵ�.

��� ����ϴ��� �ٷ� �˾ƺ����� ����.
```java
	import java.util.HashSet;

	public class SetExam extends HashSet<String> {
		public SetExam(String[] args) {
			//super(5);
			for(String s : args) {
				boolean re = super.add(s);
				System.out.println(s + "�߰� ��� : " + re);
			}
			
			System.out.println("--��ϰ��--");
			System.out.println(this);
			
			// �߰��� �κ�
			Iterator<String> it = super.iterator(); //super�� ������ �θ��� HashSet�� ������ �ֱ� �����̴�.
			while(it.hasNext()) {
				String name = it.next();
				System.out.println(name);
			}
			// �߰��� �κ�
			
		}
		public static void main(String[] args) {
			new SetExam(args);
		}
	}
```
