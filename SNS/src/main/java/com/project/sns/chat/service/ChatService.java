package com.project.sns.chat.service;

import java.util.List;

import com.project.sns.chat.vo.ChatVO;


public interface ChatService {
	
	public int submit(ChatVO vo);
	public List<ChatVO> getChatListById(ChatVO vo);
	public List<ChatVO> getChatListByRecent(ChatVO vo);
	public int readChat(ChatVO vo);
	public int newChat(ChatVO vo);
}
