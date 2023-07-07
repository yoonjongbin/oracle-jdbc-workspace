package com.youtube.model.vo;

import java.util.Scanner;

public class Application {
	
	
	public YoutubeController yc = new YoutubeController();
	private  Scanner sc  new Scanner(System.in);
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Application app = new Application();
	}
	
	public void register() {
		System.out.print("아이디 입력 : ");
		String id = sc.nextLine();
		System.out.print("비번 입력 : ");
		String pwd = sc.nextLine();
		System.out.print("닉네임 입력 : ");
		String nickName = sc.nextLine();
		
		
		Member member = new Member();
		member.setMemberId(id);
		member.setMemberPassword(pwd);
		member.setMemberNickname(nickName);
	}

	
	public void login() {
		System.out.print("아이디 입력 : ");
		String id = sc.nextLine();
		System.out.print("비번 입력 : ");
		String pwd = sc.nextLine();
	}
	
	public void addchannel() {
		yc.login("user1", "1234");
		
		
		System.out.print("채널명 : ");
		String title = sc.nextLine();
		Channel channel = new Channel();
		
		channel.setChannelName(title);
		if(yc.addChannel(channel)) {
			System.out.println("채널이 추가 되었습니다.");
		} else {
			System.out.println("채널 추가실패");
		}
	}
	
	public void updateChannel(Channel channel) {
		
		channelDao.updateChannel(channel);
	}
	
	public void deleteChannel() {
		
	}
	
	public void myChannel() {
		
	}
}
