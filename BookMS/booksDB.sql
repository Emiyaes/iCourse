CREATE DATABASE booksDB
ON PRIMARY
(NAME = 'booksDB_DATA',
FILENAME = 'C:\Users\ww\���ݿ�ϵͳ\booksDB.MDF',
SIZE = 5MB,
MAXSIZE = 30MB,
FILEGROWTH = 20%)
LOG ON
(NAME = 'booksDB_LOG',
FILENAME = 'C:\Users\ww\���ݿ�ϵͳ\booksDB.LDF',
SIZE = 5MB,
MAXSIZE = 30MB,
FILEGROWTH =3MB)
USE booksDB
GO
CREATE TABLE ReaderType(  
rdType         INT PRIMARY KEY,    --��������  
rdTypeName    VARCHAR(20),         --�����������  
canLendQty    INT,                 --�ɽ�������  
canLendDay    INT)                 --�ɽ�������
CREATE TABLE reader(
rdID		 char(9)primary key,				--���߱��
rdType       INT REFERENCES ReaderType(rdType),			--�������
rdName       VARCHAR(20),					--��������  
rdDept       VARCHAR(40),					--���ߵ�λ  
rdQQ         VARCHAR(13),					--����QQ  
rdBorrowQty  INT  DEFAULT 0 CHECK(rdBorrowQty BETWEEN 0 AND 10))--�ѽ�������
CREATE TABLE Book( 
bkID        CHAR(9)  PRIMARY KEY,   --���  
bkName		VARCHAR(50),			--����  
bkAuthor    VARCHAR(50),			--����  
bkPress     VARCHAR(50),			--������  
bkPrice     DECIMAL(5,2),			--����  
bkStatus    INT DEFAULT 1)			--�Ƿ��ڹݣ�1���ڹݣ� 0�����ڹ�
CREATE TABLE Borrow(  
rdID            CHAR(9)  REFERENCES Reader(rdID),       --���߱��  
bkID            CHAR(9)  REFERENCES Book(bkID),         --���  
DateBorrow      DateTime,         --��������  
DateLendPlan    DateTime,         --Ӧ������  
DateLendAct     DateTime,         --ʵ�ʻ�������  
PRIMARY KEY(rdID, bkID) ) 
USE booksDB
GO
INSERT INTO ReaderType
VALUES
('1','��ʦ','10','60'),
('2','������','5','30'),
('3','˶ʿ�о���','6','40'),
('4','��ʿ�о���','8','50')
USE booksDB
GO
INSERT INTO Reader
VALUES
('rd2017001','1','����Ⱥ','�������ѧѧԺ','3635751','0'),
('rd2017002','2','��С��','Ӣ��ѧԺ','11223344','0'),
('rd2017003','3','��С��','����ѧԺ','5599663','0'),
('rd2017004','4','����','����ѧԺ','88552277','0')

INSERT INTO Book
VALUES
('bk2017001','���ݿ�ԭ��','������','��е��ҵ������','33.00','1'),
('bk2017002','�ߵ���ѧ','ͬ�ô�ѧ��ѧϵ','�ߵȽ���������','37.00','1'),
('bk2017003','������������ѧ','����','����ʦ����ѧ','37.20','1'),
('bk2017004','�Ŵ�����','����','�л����','20.40','1')

SELECT rdID,rdName FROM Reader

SELECT ���=rdID,����=rdName,��λ=rdDept FROM Reader

SELECT * FROM Reader

SELECT rdID FROM Reader
WHERE rdBorrowQty > 0

SELECT bkID,bkName FROM Book
WHERE bkPrice > 30

SELECT rdName,rdQQ FROM Reader
WHERE rdDept NOT IN ('����ѧԺ','����ѧԺ')

SELECT rdName,rdQQ,rdDept FROM Reader
WHERE rdName LIKE ('��%')

SELECT rdName,rdQQ,rdDept FROM Reader
WHERE rdName NOT LIKE ('��%')

SELECT rdName,rdQQ,rdDept FROM Reader
WHERE rdName LIKE('__')

SELECT Borrow.rdID,Borrow.bkID,Borrow.DateBorrow,Borrow.DateLendAct,Borrow.DateLendPlan
FROM Borrow INNER JOIN Book
ON Borrow.bkID = Book.bkID AND Book.bkStatus = 0

SELECT COUNT(*)AS'��������'FROM Reader

SELECT COUNT(DISTINCT rdID)AS'�ѽ���������'FROM Reader

SELECT MAX(bkprice)AS'��ߵ���'FROM Book

SELECT rdDept,COUNT(rdID)AS'��������'FROM Reader
GROUP BY rdDept

SELECT rdDept,COUNT (rdID)AS'��������'FROM Reader
GROUP BY rdDept
HAVING COUNT(rdDept) > 40

SELECT rdName,rdDept from reader 
WHERE rdType = '1'

SELECT Reader.rdID,Reader.rdName,ReaderType.canLendQty
FROM ReaderType,Reader
WHERE Reader.rdType = ReaderType.rdType AND Reader.rdDept = '����ѧԺ'

SELECT Reader.rdName,ReaderType.canLendQty,ReaderType.canLendDay
FROM Reader,Borrow,ReaderType
WHERE Reader.rdType = ReaderType.rdType AND Reader.rdID = Borrow.rdID AND Borrow.bkID = '2017001'

SELECT *
FROM ReaderType FULL JOIN Reader ON ReaderType.rdType = Reader.rdType FULL JOIN Borrow ON Borrow.rdID = Reader.rdID

SELECT * FROM Reader
WHERE rdDept = (SELECT rdDept FROM Reader WHERE rdName = '������'

SELECT Reader.rdID,Reader.rdName
FROM Reader,Borrow,Book
WHERE Reader.rdID = Borrow.rdID AND Book.bkID = Borrow.bkID AND Book.bkName = '�ߵ���ѧ'

SELECT rdName 
FROM Reader
WHERE rdID NOT IN (SELECT rdID FROM Borrow WHERE bkID = 'bk2017004'

SELECT rdName FROM Reader WHERE rdDept = '����ѧԺ'
UNION
SELECT rdName FROM Reader WHERE rdBorrowQty < 4

SELECT rdName FROM Reader WHERE rdDept = '����ѧԺ'
INTERSECT
SELECT rdName FROM Reader WHERE rdBorrowQty < 4

SELECT rdName FROM Reader WHERE rdDept = '����ѧԺ'
EXCEPT
SELECT rdName FROM Reader WHERE rdBorrowQty < 4

INSERT INTO Reader
VALUES ('2017007','1','¬С��','�������ѧѧԺ','932200777',

INSERT INTO Borrow
VALUES ('2017007','bk2017004','2017-3-8')

UPDATE Reader
SET rdQQ = '3635763'
WHERE rdID = 'rd2017001'

UPDATE Reader
SET rdType = '2'
WHERE rdID = 'rd2017001'

TRUNCATE TABLE Borrow