package com.project.sns.board.vo;

import java.sql.Date;

public class BoardVO {
	private Integer board_seq;
	private Integer line_seq;
	private String title;
	private String writer;
	private String content;
	private Date regdate;
	private Integer heart;
	private String heart_id;

	public BoardVO(Integer board_seq, Integer line_seq, String title, String writer, String content,
			Date regdate, Integer heart, String heart_id) {
		this.board_seq = board_seq;
		this.line_seq = line_seq;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.regdate = regdate;
		this.heart = heart;
		this.heart_id = heart_id;
	}

	public Integer getBoard_seq() {
		return board_seq;
	}

	public Integer getLine_seq() {
		return line_seq;
	}

	public String getTitle() {
		return title;
	}

	public String getWriter() {
		return writer;
	}

	public String getContent() {
		return content;
	}

	public Date getRegdate() {
		return regdate;
	}

	public Integer getHeart() {
		return heart;
	}

	public String getHeart_id() {
		return heart_id;
	}
		
}