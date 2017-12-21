package com.project.sns.board.vo;

import java.sql.Date;

public class ReplyVO {
	private Integer seq;
	private Integer board_seq;
	private Integer line_seq;
	private String writer;
	private String content;
	private Date regdate;
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public Integer getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(Integer board_seq) {
		this.board_seq = board_seq;
	}
	public Integer getLine_seq() {
		return line_seq;
	}
	public void setLine_seq(Integer line_seq) {
		this.line_seq = line_seq;
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
	
}
