
CREATE TABLE NewBooks
( 
	bookname             nvarchar(100)  NOT NULL ,
	price                integer  NULL ,
	bookid               integer  NOT NULL ,
	pubname              nvarchar(50)  NOT NULL ,
	pubdate              datetime  NOT NULL 
)
go



ALTER TABLE NewBooks
	ADD CONSTRAINT XPK도서 PRIMARY KEY  CLUSTERED (bookid ASC)
go



CREATE TABLE NewCustomer
( 
	custid               integer  NOT NULL ,
	name                 nvarchar(40)  NOT NULL ,
	address              nvarchar(120)  NOT NULL ,
	phone                varchar(20)  NULL 
)
go



ALTER TABLE NewCustomer
	ADD CONSTRAINT XPK고객 PRIMARY KEY  CLUSTERED (custid ASC)
go



CREATE TABLE NewOrder
( 
	bookid               integer  NOT NULL ,
	custid               integer  NOT NULL ,
	orderdate            datetime  NOT NULL ,
	saleprice            integer  NOT NULL ,
	orderid              integer  NOT NULL 
)
go



ALTER TABLE NewOrder
	ADD CONSTRAINT XPK주문 PRIMARY KEY  CLUSTERED (orderid ASC)
go



CREATE TABLE NewPublisher
( 
	pubname              nvarchar(50)  NOT NULL ,
	stname               nvarchar(40)  NOT NULL ,
	officephone          varchar(20)  NULL 
)
go



ALTER TABLE NewPublisher
	ADD CONSTRAINT XPK출판사 PRIMARY KEY  CLUSTERED (pubname ASC)
go




ALTER TABLE NewBooks
	ADD CONSTRAINT R_15 FOREIGN KEY (pubname) REFERENCES NewPublisher(pubname)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE NewOrder
	ADD CONSTRAINT OrdBook FOREIGN KEY (bookid) REFERENCES NewBooks(bookid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE NewOrder
	ADD CONSTRAINT OrdCustomer FOREIGN KEY (custid) REFERENCES NewCustomer(custid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go