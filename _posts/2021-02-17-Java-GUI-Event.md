---
date: 2021-02-17 08:13:42
layout: post
title: Java GUI Event
description: 요새는 잘 사용하지 않지만, awt와 swing을 활용하여 GUI와 Event처리 방법을 알아보자
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
# GUI
>다음 import 구문을 추가해야 한다.
import java.awt*
import javax.swing.*;

먼저 awt을 사용하여 화면 구성을 하면 운영체제에 따라 조금씩 다르다.
Frame, Button, TextField와 같은 키워드를 사용한다.

swing은 awt를 기본적으로 상속받고 있고, 자체적인 look and feel을 가지고 있어서 자체적으로 가지고 있는 그래픽을 사용한다. 따라서 모든 운영체제에서 동일한 그래픽을 보여준다.
JFrame, JButton, JTextField와 같은 키워드를 사용한다.

따라서 **swing**의 사용을 좀 더 권고한다.

### 용어 정리
**Container** : 창문의 역할을 한다. 다양한 Component 들이 Container위에 올려져서 화면 구성을 한다. 반드시 하나 이상의 Contaier가 있어야 화면 구성을 할 수 있다.
>ex) JFrame, JPanel, JDialog 등..

**Component** : 화면 구성을 담당하는 요소들. Component들은 반드시 Container위에 올려져야 화면에 보여질 수 있다. 
>ex) JTextField, JTextArea, JButton, JComboBox, JChechBox 등..

**LayoutManager** : Container위에 Component들이 올려질 때 위치를 설정하는 방법이다.
>ex) BorderLayout, FlowLayout, GridLayout, CardLayout, GridBagLayout

```java
public class JFrameExam extends JFrame{
	JButton btn1 = new JButton("클릭1");
	JButton btn2 = new JButton("클릭2");
	JTextField text= new JTextField("재미있네요", 30);
	public JFrameExam() {
		super("JFrame 입니다."); //Title
		super.setSize(300, 300); //윈도우 창 사이즈 조정
		super.setLocationRelativeTo(null); //화면이 출력되는 위치를 가운데로 조정
		super.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); //X를 누르면 프로그램도 같이 종료
		super.setVisible(true); //창이 사용자에게 보여질 수 있도록 지정
		super.setLayout(new FlowLayout()); //layout을 Flow로 지정
		
		Container con = super.getContentPane();
		con.add(btn1);
		con.add(btn2);
		con.add(text);
	}
	
	public static void main(String[] args) {
		new JFrameExam();
	}
}
```

## EVENT처리하기

사용자의 어떤 행동이 일어났을 때 -> 기능을 한다. -> 이벤트핸들러
처리 순서 : 
1. 어떤 Component에서 이벤트가 발생하는지 주체를 찾는다.
2. 1번에서 찾은 Component가 발생하는 이벤트종류를 찾는다.
3. XxxEvent에 해당하는 이벤트 핸들러를 구현한다.
> XxxListener-interface 또는 XxxAdater-class를 사용한다.
> XxxAdapter 클래스는 XxxListener룰 미리 implements해 놓은 구현 abstract 클래스이다.
> XxxAdapter 클래스를 사용하면 필요한 메소드만 재 정의해서 사용할 수 있다.
4. 이벤트 등록을 한다.
> 이벤트 주체.addXxxListener(이벤트를 처리한 객체);
> **이벤트를 처리한 객체**는
> - this
> - new 클래스 이름()
> - Anonymous 클래스 - 익명클래스 형태가 올 수 있다.

```java
//interface를 상속 받아야 함!

public class JFrameExam extends JFrame implements ActionListener{
	JButton btn1 = new JButton("클릭1");
	JButton btn2 = new JButton("클릭2");
	JTextField text= new JTextField("재미있네요", 30);
	public JFrameExam() {
		super("JFrame 입니다.");
		super.setSize(300, 300);
		super.setLocationRelativeTo(null);
		super.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		super.setVisible(true);
		super.setLayout(new FlowLayout());
		
		Container con = super.getContentPane();
		con.add(btn1);
		con.add(btn2);
		con.add(text);
		btn1.addActionListener(this); // 자기 자신을 넘김
		btn2.addActionListener(this);
	}

	@Override
	public void actionPerformed(ActionEvent e) { //addActionListener으로 넘어온 이벤트를 받음
		Object objEvent = e.getSource(); //받았을 때 무엇으로부터 받았는지 체크, e.getSource()는 Object형을 반환한다.
		if(objEvent == btn1) {
			text.setText("내용 변화");
		} else {
			System.exit(0);
		}
	}
	
	public static void main(String[] args) {
		new JFrameExam();
	}
}
```

## Adapter
만약 x와 y좌표를 출력하고 싶어서 implements으로 mouse에 관련된 정보들을 찾아보면
MouseListener라는 interface가 나온다.

그러나 그 interface를 implements를 하면 다음과 같은 에러메시지가 나온다.
![errorMessage](https://user-images.githubusercontent.com/68142821/108168065-08866780-713a-11eb-9a0b-83fafb8caef9.png)

이는 interface 안에 있는 메소드를 재 정의하라는 의미인데, 우리는 저 많은 메소드를 **사용할 필요가 없다.** 즉, 우리는 사용할 메소드만을 뽑아내는 작업이 필요로 한데, 그때 필요한 것이 **Adapter**이다.

Adapter는 해당 interface와 관련된 모든 메소드를 이미 재 정의를 해둔 상태여서 그 클래스만 상속을 받게 되면 **모든 메소드를 재 정의할 필요가 없어진다.**

Adapter는 abstract클래스로 생성되어 있으며 상속을 받아야 하는데, 우리는 이전에 JFrame이라고 하는 녀석을 상속받았다. 그렇기 때문에 또 다른 클래스를 생성해야 한다.
```java
class MEventExam extends MouseAdapter {
	JTextField jTextField;
	
	public MEventExam(JTextField jTextField) { //이전에 만든 TextField의 값을 바꾸기 위해 생성자로 받아왔다.
											   //같은 클래스가 아니기 때문에 값을 넘겨주어야만 한다.
		this.jTextField = jTextField;
	}
	
	@Override
	public void mouseClicked(MouseEvent e) {
		int x = e.getX();
		int y = e.getY();
		jTextField.setText(x + " : " + y);
	}
}
```

이것을 호출하려면 이전에 만들었던 클래스에
`this.addMouseListener(new MEventExam(text));` 구문을 추가하면 된다.
여기서 this는 super로 대체 가능하며 JFrame을 칭하는 의미이다.

즉, JFrame을 클릭하면 이 마우스이벤트가 실행되는 것이다.

그러나 방금은 TextField만 넘겨주면 되어서 이 클래스에 text객체를 넘겨주었지만,
**많은 수정이 필요하거나, 클래스 전체가 객체**로 보내지기를 원한다면

`this.addMouseMotionListener(new MDragExam(this));` 이러한 형식으로 사용하면 된다.
이것까지 사용한 것에 대해 전체 코드를 올려보겠다.
```java
public class JFrameExam extends JFrame implements ActionListener{
	JButton btn1 = new JButton("클릭1");
	JButton btn2 = new JButton("클릭2");
	JTextField text= new JTextField("재미있네요", 30);
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
		this.addMouseListener(new MEventExam(text));
		this.addMouseMotionListener(new MDragExam(this)); //자기 자신의 주소를 넘겨버림
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		Object objEvent = e.getSource();
		if(objEvent == btn1) {
			text.setText("내용 변화");
		} else {
			System.exit(0);
		}
	}
	
	public static void main(String[] args) {
		new JFrameExam();
	}
}

class MEventExam extends MouseAdapter {
	JTextField jTextField;
	
	public MEventExam(JTextField jTextField) {
		this.jTextField = jTextField;
	}
	
	@Override
	public void mouseClicked(MouseEvent e) {
		int x = e.getX();
		int y = e.getY();
		jTextField.setText(x + " : " + y);
	}
}

class MDragExam extends MouseMotionAdapter {
	JFrameExam jFrameExam;
	
	public MDragExam(JFrameExam jFrameExam) { //클래스 전체를 객체로서 사용 가능
		this.jFrameExam = jFrameExam;
	}
	
	@Override
	public void mouseDragged(MouseEvent e) {
		int x = e.getX();
		int y = e.getY();
		jFrameExam.btn1.setText(String.valueOf(x));
		jFrameExam.btn2.setText(String.valueOf(y));
		
		jFrameExam.setTitle("x : " + x + ", y : " + y);
	}
}
```

### 출력화면
![print](https://user-images.githubusercontent.com/68142821/108170957-2950bc00-713e-11eb-9b3b-f0f598eef91c.png)
