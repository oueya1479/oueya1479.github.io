---
date: 2021-02-17 09:20:23
layout: post
title: Java GUI Inner & Anonymous
description: 이전 post에서 작성한 코드를 기반으로 Inner클래스를 활용하는 방법과 Anonymous 클래스를 활용하는 방법을 알아본다.
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->

# Inner class
이전 post에서 다른 GUI와 Event처리한 class 파일을 기준으로 설명해보려고 한다.
Inner class는 간단하게 설명하자면 클래스 안의 클래스가 있는 것이다.

왜 이런 형식을 만드는지 이해가 가지 않을 수도 있지만,
먼저 장점은 **inner클래스 바깥에 있는 클래스 모든 속성이나 메소드에 접근**할 수 있다.

상속이 없이도 접근 가능한 탓에 자유도는 높지만, 치명적인 단점이 존재하는데
그것은 **바깥에 있는 클래스의 존재 없이는 사용이 불가능**하다는 것이다.

결국 Inner클래스는 outer클래스에 의존적일 수 밖에 없다.

하지만 이전 post에서 실습 해본 MouseAdapter는 JFrame을 상속받는 클래스의 의존적일 수 밖에 없으므로 Inner클래스 형식으로 바꾸는 작업을 해도 상관없다.
```java
package ex0217.inner;

import java.awt.Container;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;

import javax.swing.*;

public class JFrameExam extends JFrame implements ActionListener {
	JButton btn1 = new JButton("클릭1");
	JButton btn2 = new JButton("클릭2");
	JTextField text = new JTextField("재미있네요", 30);

	public JFrameExam() {
		super("JFrame 입니다.");
		super.setSize(400, 300);
		super.setLocationRelativeTo(null);
		super.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		super.setVisible(true);
		super.setLayout(new FlowLayout());

		Container con = super.getContentPane();
		con.add(btn1);
		con.add(btn2);
		con.add(text);
		btn1.addActionListener(this);
		btn2.addActionListener(this);
		this.addMouseListener(new MEventExam());
		this.addMouseMotionListener(new MDragExam());
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		Object objEvent = e.getSource();
		if (objEvent == btn1) {
			text.setText("내용 변화");
		} else {
			System.exit(0);
		}
	}
	
	class MEventExam extends MouseAdapter { //클래스가 내부로 들어오게 되면서 생성자로 받을 필요가 사라졌다.
											//위에 있는 모든 속성과 메소드의 접근이 가능하다.
		@Override
		public void mouseClicked(MouseEvent e) {
			int x = e.getX();
			int y = e.getY();
			text.setText(x + " : " + y);
		}
	}

	class MDragExam extends MouseMotionAdapter {

		@Override
		public void mouseDragged(MouseEvent e) {
			int x = e.getX();
			int y = e.getY();
			btn1.setText(String.valueOf(x));
			btn2.setText(String.valueOf(y));
			
			//inner클래스 안에서 outer의 객체를 접근할 때 this, super가 바로 되지 않기 때문에
			//다음 문법을 사용해야 한다.
			JFrameExam.this.setTitle("x : " + x + ", y : " + y);
		}
	}
	
	public static void main(String[] args) {
		new JFrameExam();
	}
}

```

# Anonymous class
익명의 클래스를 가진다는 의미이다.
우리는 ActionListner를 상속 받았기 때문에 interface 안의 메소드를 재 정의해서 사용하는 것이 필요로 하였다. 그러나 익명의 클래스를 선언하면 <코드1>의 형식은 <코드2>의 형식으로 바뀔 수 있다.
### <코드1>
```java
	btn1.addActionListener(this);
	btn2.addActionListener(this);
```
### <코드2>
```java
	btn1.addActionListener(new ActionListener() {
		@Override
		public void actionPerformed(ActionEvent e) {
			text.setText(e.getActionCommand() + " 클릭");
		}
	});
	btn2.addActionListener(new ActionListener() {
		@Override
		public void actionPerformed(ActionEvent e) {
			text.setText(e.getActionCommand() + " 클릭");
		}
	});
```

더 긴 형식으로 바뀌기 때문에 <코드2>로 바꾸는 것에 대한 의문이 들 수가 있다.
그러나 우리가 이전에 아래에 Inner클래스로 작성한 것들은 단순히 **일회성**으로 사용하는 클래스들이었고, 재 사용하기에 어려운 부분이 있다고 판단하게 되면, **익명 클래스 선언**을 사용할 수 있다.

그 아래있는 MouseAdapter를 사용한 부분도 함께 바꿀 수 있다.
```java
	this.addMouseListener(new MEventExam());
	this.addMouseMotionListener(new MDragExam());
```

**익명 클래스**의 구현은 선언과 동시에 기능을 나열하는 것이다.
```java
	this.addMouseListener(new MouseAdapter() {
		@Override
		public void mouseClicked(MouseEvent e) {
			int x = e.getX();
			int y = e.getY();
			text.setText(x + " : " + y);
		}
	});
	this.addMouseMotionListener(new MouseMotionAdapter() {
		@Override
		public void mouseDragged(MouseEvent e) {
			int x = e.getX();
			int y = e.getY();
			btn1.setText(String.valueOf(x));
			btn2.setText(String.valueOf(y));
			setTitle("x : " + x + ", y : " + y);
		}
	});
```