-- testname, testquestion, testexample

-- image
LOAD DATA LOCAL INFILE "D:\\workspace\\workspace_spring\\Omori_Ver2\\DataFiles\\image.txt" 
	INTO TABLE image character set utf8
	FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
select * from image;

-- selected_answer
LOAD DATA LOCAL INFILE "D:\\workspace\\workspace_spring\\Omori_Ver2\\DataFiles\\selectedAnswer5.txt" 
	INTO TABLE selected_answer character set utf8
	FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n'
	set sa_date = now();

-- now_grade
LOAD DATA LOCAL INFILE "D:\\workspace\\workspace_spring\\Omori_Ver2\\DataFiles\\nowgrade5.txt" 
	INTO TABLE nowgrade character set utf8
	FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n'
	set ng_date = now();

-- grade
LOAD DATA LOCAL INFILE "D:\\workspace\\workspace_spring\\Omori_Ver2\\DataFiles\\grade5.txt" 
	INTO TABLE grade character set utf8
	FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
delete from grade;
alter table grade auto_increment = 1;
select * from grade;