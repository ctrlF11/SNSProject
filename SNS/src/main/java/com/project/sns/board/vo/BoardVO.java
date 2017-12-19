package com.project.sns.board.vo;

public class BoardVO {
	private int board_seq;
	private int line_seq;
	private String title;
	private String writer;
	private String content;
	private String regDate;
	private int heart;
	
	public BoardVO(int board_seq, int line_seq, String title, String writer, String content, String regDate, int heart) {
		super();
		this.board_seq = board_seq;
		this.line_seq = line_seq;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.regDate = regDate;
		this.heart = heart;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public int getLine_seq() {
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

	public String getRegDate() {
		return regDate;
	}

	public int getHeart() {
		return heart;
	}	
}
