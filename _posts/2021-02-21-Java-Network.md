---
date: 2021-02-21 14:22:32
layout: post
title: Java Network
description: empty
image: https://user-images.githubusercontent.com/68142821/107894405-eee6f380-6f72-11eb-9e60-8935d929de70.png
tags:
  - programming
  - java
author: Dongheon Kim
---

<!--page-->
# Network
> import java.net.*;를 포함하도록 하자.

네트워크를 통한 통신 방법에는 두 가지가 있다.

1. UDP방식 : 비 연결성 통신 방법으로, 일정량의 패킷을 모아 두었다가 한번에 전송하는 방식이다. 필요할 때 연결해서 통신하며, 네트워크 부담은 낮고, 신뢰성도 낮다. 먼저 보낸 데이터가 먼저 도착하는 것을 보장할 수 없고, 데이터 분실 가능성도 있다.
ex) 우체국, DatagramPacket, DatagramSocket

2. TCP방식 : 연결성 통신 방법으로 24시간 연결되어 있다. 먼저 전송한 데이터가 먼저 도착하며, 신뢰성은 높지만 네트워크 부담이 크다. 
ex) email, ServerSocket, Socket