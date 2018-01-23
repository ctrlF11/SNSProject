package com.project.sns.board.vo;

import java.sql.Date;

public class BoardVO {
	private Integer board_seq;
	private Integer story_seq;
	private String title;
	private String writer;
	private String tel;
	private String content;
	private String contentID;
	private String mtitle;
	public Integer getStory_seq() {
		return story_seq;
	}
	public void setStory_seq(Integer story_seq) {
		this.story_seq = story_seq;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getContentID() {
		return contentID;
	}
	public void setContentID(String contentID) {
		this.contentID = contentID;
	}
	public String getMtitle() {
		return mtitle;
	}
	public void setMtitle(String mtitle) {
		this.mtitle = mtitle;
	}
	private Date regdate;
	private Integer heart;
	private String heart_id;
	public Integer getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(Integer board_seq) {
		this.board_seq = board_seq;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Integer getHeart() {
		return heart;
	}
	public void setHeart(Integer heart) {
		this.heart = heart;
	}
	public String getHeart_id() {
		return heart_id;
	}
	public void setHeart_id(String heart_id) {
		this.heart_id = heart_id;
	}

	
}