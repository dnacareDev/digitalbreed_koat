package kr.or.ih.api.entity;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("User")
public class User
{
	private int user_id;
	private String user_username;
	private String user_password;
	private int user_status;
	private int user_type;
	private String create_date;
	private String modify_date;
}