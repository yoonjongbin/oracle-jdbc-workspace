package com.youtube.controller;

import com.youtube.model.vo.Channel;
import com.youtube.model.vo.Member;

public class YoutubeCotroller {
	public boolean register(Member member) {
		if(memberDao.register(member) == 1) return true;
		return false;
	}
	
public void updateChannel(Channel channel) {
		
		if(channelDao.updateChannel(channel) == 1) return true;
		return false;
	}
	
	public void deleteChannel() {
		
	}
	
	public void myChannel() {
		
	}
	
}
