---
date: 2021-02-20 13:04:11
layout: post
title: Java Thread
description: empty
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->

# Thread
**스레드**란 하나의 프로세스 내에 작업을 잘게 쪼개어 놓은 상태를 일컬으며,
**멀티스레드**는 이러한 작업을 번갈아가면서 하도록 하는 것이다. 즉, 여러 개의 작업이 동시에 일을 하는 것 처럼 만드는 것이다.

Thread환경은 왜 필요할까?
Thread는 여러 가지 작업을 **동시에 일을 수행하는 것은 아니다.** 예를 들어, 아이스크림 하나 사러 마트에 갔는데, 앞에 있는 사람이 20개 이상의 물품을 구매하고 있을 때, 아이스크림 하나 때문에 많은 시간을 소비하게 된다. 결국은, 앞의 사람과 내가 번갈아가며 시간을 소비하면서 결제했다면, **빨리 끝날 수 있었던 작업**은 빨리 끝내게 해 주었을 것이다.

우리가 지금까지 작업했었던 main도 하나의 Thread이다. 그러면, 어떻게 사용하는지 알아보겠다.

## Thread 작성법
상속하는 법
```java
class A extends Thread {
	public void run() {
		//Thread로 동작할 기능 작성
	}
	public static void main(String[] args) {
		A a = new A();
		a.start();
	}
}
```

```java
class B implements Runnable {
	public void run() {
		//Thread로 동작할 기능 작성
	}

	public static void main(String[] args) {
		B b = new B();
		//b.start();
		Thread th = new Thread(b);
		th.start();
	}
}
```

다음과 같이 작업하면 된다.
```java
class ThreadExam extends Thread {
	public static void main(String[] args) {
		NumberThread th1 = new NumberThread("첫번째 Thread");
		
		AlphaThread alphath = new AlphaThread();
		Thread th2 = new Thread(alphath, "두번째 Thread");
		th1.setPriority(MAX_PRIORITY);
		th2.setPriority(MIN_PRIORITY);
	
		th1.start();
		th2.start();
		
		System.out.println("========main끝=========");
	}
}

class NumberThread extends Thread {
	int sum;
	public NumberThread(String name) {
		super(name);
	}
	@Override
	public void run() {
		for(int i = 1; i <= 100; i++) {
			System.out.println(super.getName() + " => " + i + " " + super.getPriority());
			sum += i;
		}
		
		System.out.println(super.getName() + "End");
	}
}

class AlphaThread implements Runnable {
	@Override
	public void run() {
		Thread th = Thread.currentThread();
		for(char ch='A'; ch <= 'Z'; ch++) {
			System.out.println(th.getName() + " => " + ch + " " + th.getPriority());
		}
	}
}
``` 

![image](https://user-images.githubusercontent.com/68142821/108665709-e9604f00-7518-11eb-91bc-56465c6b6fb1.jpg)

## Synchronized
Thread를 사용하다 보면, 오류가 발생할 수도 있다.
이때에 **오류**란 컴파일 오류나 Exception이 아닌, 기존 데이터 분실에 대한 내용이다.

두 개의 스레드가 존재하고 있고, 하나는 입금, 하나는 출금이라 해보자. 그러면 입금스레드가 실행되면 돈이 입금되고, 출금은 그의 반대가 되겠다. 실행하면 예상과는 달리, **순서도 뒤죽박죽으로 나오며, 어떤 부분을 원금으로 잡을지 판단하지 못해 결국 데이터 분실이 일어난다.**

다음 코드를 확인해보자.

```java
public class SynchronizedExam {
	public static void main(String[] args) {
		Bank bank = new Bank();
		
		new CustomerThread("생산자", true, bank).start(); //같은 bank를 넣으므로써 하나의 은행만 만들어준다.
		new CustomerThread("소비자", false, bank).start();
	}
}

class Bank {
	int balance;
	
	public /*synchronized*/ void balanceChane(String name, boolean state) {
		if(state) {
			System.out.print(name + "==> 현재 잔액 : " + balance + ", ");
			balance++;
			System.out.println(name + "==> 증가 후 잔액 : " + balance);
		} else {
			System.out.print(name + "==> 현재 잔액 : " + balance + ", ");
			balance--;
			System.out.println(name + "==> 증가 후 잔액 : " + balance);
			
		}
	}
}

class CustomerThread extends Thread {
	String name;
	boolean state;
	Bank bank;
	
	public CustomerThread(String name, boolean state, Bank bank) {
		super(name);
		
		this.name = name;
		this.state = state;
		this.bank = bank;
	}
	
	@Override
	public void run() {
		for(int i = 0; i < 50; i++) {
			bank.balanceChane(name, state);
		}
	}
}
```

Synchronized, 그 블럭안에 있는 스레드가 자신의 일을 모두 끝날 때까지 다른 스레드가 제어 권을 뺏어갈 수 없는 것이다. 이는
1. 메소드의 선언부
2. 메소드 내부의 synchronized블럭을 만들어서 사용
와 같은 방법으로 선언할 수 있으며,

synchronized 블럭안에서 스레드를 제어하기 위한 메소드로는
1. wait() : 현재 스레드를 중지 상태로 만듦
2. notify() : wait()에 의해 중지 상태인 스레드 중에서 우선순위가 높은 스레드를  대기상태로 만듦
3. notifyAll() : 모든 중지중인 상태의 스레드를 준비 상태로 만든다.
  
## 데몬스레드
시계나 while구문으로 계속 돌려야 하는 스레드가 있다면, 메인스레드가 종료될 때 함께 종료되는 것을 원할 때 **데몬스레드**를 사용한다.

말은 거창하지만, 일단 코드를 보면 생각보다 간단하다.
```java
package step08_Thread;

public class DeamonThreadExam {
	public static void main(String[] args) {
		System.out.println("==메인 시작==");
		Thread th = new Thread() {
			public void run() {
				while(true) {
					System.out.println("안녕");
					try {
						Thread.sleep(100);
					} catch(Exception e) {
						e.printStackTrace();
					}
				}
			};
		};
		
		th.setDaemon(true); //메인스레드가 종료되는 순간 th스레드도 종료된다!
		th.start();
		
		try {
			Thread.sleep(1000);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("==메인 끝==");
	}
}
```