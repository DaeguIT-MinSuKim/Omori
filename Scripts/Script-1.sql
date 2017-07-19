-- testname, testquestion, testexample

-- image
LOAD DATA LOCAL INFILE "E:\\workspace\\workspace_spring\\Omori_2\\DataFiles\\image.txt" 
	INTO TABLE image character set utf8
	FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
select * from image;

-- selected_answer
LOAD DATA LOCAL INFILE "E:\\workspace\\workspace_spring\\Omori_2\\DataFiles\\selectedAnswer1.txt" 
	INTO TABLE selected_answer character set utf8
	FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n'
	set sa_date = now();

-- now_grade
LOAD DATA LOCAL INFILE "E:\\workspace\\workspace_spring\\Omori_2\\DataFiles\\nowgrade.txt" 
	INTO TABLE nowgrade character set utf8
	FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n'
	set ng_date = now();

-- grade
LOAD DATA LOCAL INFILE "E:\\workspace\\workspace_spring\\Omori_2\\DataFiles\\grade.txt" 
	INTO TABLE grade character set utf8
	FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
	
select * from grade;