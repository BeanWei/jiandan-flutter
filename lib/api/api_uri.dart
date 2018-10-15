class ApiUri {
  static final String MeiZi_List = 'http://jandan.net/?oxwlxojflwblxbsapi=jandan.get_ooxx_comments&page=@page';
  static final String WuLiao_List = 'http://jandan.net/?oxwlxojflwblxbsapi=jandan.get_pic_comments&page=@page';
  static final String DuanZi_List = 'http://jandan.net/?oxwlxojflwblxbsapi=jandan.get_duan_comments&page=@page';
  static final String News_List = 'http://jandan.net/?oxwlxojflwblxbsapi=get_recent_posts&include=url,date,tags,author,title,excerpt,comment_count,comment_status,custom_fields&custom_fields=thumb_c,views&dev=1&page=@page';
  static final String News_Detail = 'http://jandan.net/?oxwlxojflwblxbsapi=get_post&include=content&id=@id';
  static final String News_Comments = 'http://jandan.net/?oxwlxojflwblxbsapi=get_post&include=comments&id=@id';
}