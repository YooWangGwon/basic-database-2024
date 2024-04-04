# file : MadangBook.py
# date : 240404
# 파이썬 DB 연동 프로그램

import sys
from PyQt5 import uic
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QCloseEvent
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
import webbrowser
from PyQt5.QtWidgets import QWidget
## MSSQL 연동할 라이브러리(모듈)
import pymssql

## 전역변수(나중에 변경시 여기만 변경하면 됨)
serverName = '127.0.0.1'
userId = 'sa'
userPass = 'mssql_p@ss'
dbName = 'Madang'
dbCharset = 'UTF-8'

# 저장버튼 클릭시 삽입, 수정을 구분짓기 위한 구분자
mode = 'I' # U I:Insert, U:Update

class qtApp(QMainWindow):
    def __init__(self) -> None:
        super().__init__()
        uic.loadUi('./day06/MadangBook.ui',self)
        self.initUI()

    def initUI(self) -> None:   # 사용할 UI의 속성들
        # 버튼 4개에 대해서 사용등록
        self.txtBookId.setValidator(QIntValidator(self))        # 도서번호 숫자만 입력하도록 제한
        self.txtPrice.setValidator(QIntValidator(self))         # 정가에 숫자만 입력하도록 제한
        # 버튼 4개에 대한  사용등록
        self.btnNew.clicked.connect(self.btnNewClicked)         # 신규버튼 시그널(이벤트)에 대한 슬롯함수 생성요
        self.btnSave.clicked.connect(self.btnSaveClicked)       # 저장버튼
        self.btnDel.clicked.connect(self.btnDelClicked)         # 삭제버튼
        self.btnReload.clicked.connect(self.btnReloadClicked)   # 조회버튼
        self.tblBooks.itemSelectionChanged.connect(self.tblBooksSelected)   # 테이블 위젯 결과를 클릭시 발생
        self.show()

        self.btnReloadClicked() # 저장 후 조회버튼 클릭 함수 실행
  
    def btnNewClicked(self):    # 신규버튼 클릭
        global mode
        mode = 'I'
        self.txtBookId.setText('') 
        self.txtBookName.setText('') 
        self.txtPublisher.setText('') 
        self.txtPrice.setText('') 
        # 선택한 데이터에서 신규를 누르면 self.txtBookId에 대한 사용여부는 변경해줘야 함
        self.txtBookId.setEnabled(True) # txtBookId 사용 활성화

    def btnSaveClicked(self):    # 저장버튼 클릭
        # 입력검증(Validation Cheack)을 반드시 해야함 -> 기본키인 도서 번호가 UNIQUE이자 NOT NULL이 될수있게!
        # 1. 텍스트 박스를 비워두고 저장버튼을 눌러선 안된다.
        # 프로그램 안에서 칸에 아무것도 넣지 않은 상태로 DB에 데이터를 집어넣을 경우 NULL이 아닌 Empty로 들어가게된다.
        bookid = self.txtBookId.text()
        bookName = self.txtBookName.text()
        publisher = self.txtPublisher.text()
        price = self.txtPrice.text()

        print(bookid, bookName, publisher, price)
        warningMsg = '빈칸이 있습니다.\n아래 내용을 입력해주세요.\n'
        isValid = True # 빈값이 있으면 False로 변경
        if bookid == None or bookid == '':
            warningMsg += '도서 번호'
            isValid = False
        if bookName == None or bookName == '':
            warningMsg += ', 도서 제목'
            isValid = False
        if publisher == None or publisher == '':
            warningMsg += ', 출판사'
            isValid = False
        if price == None or price == '':
            warningMsg += ', 책 번호'
            isValid = False        
        
        if isValid == False:
            QMessageBox.warning(self, '저장경고', warningMsg)
            return
        
        print(mode)
        ## Mode == 'I'일때는 중복번호를 체크해야 하지만, Mode == 'U'일때는 체크해서 막으면 수정 자체가 안됨
        if mode == 'I': # INSERT 경우

            # 2. 현재 존재하는 번호를 사용했는지 체크, 이미 있는 번호면 DB입력 쿼리 실행이 안되도록 막아야함
            conn = pymssql.connect(server = serverName, user = userId, password = userPass, database = dbName, charset = dbCharset)
            cursor = conn.cursor(as_dict =False) # COUNT는 데이터가 단 1개이기 때문에 as_dict=False로 해야함->딕셔너리를 사용하지 않는다는 뜻

            query = f'''SELECT COUNT(*)
                    FROM Book
                    WHERE bookid = {bookid}'''
            cursor.execute(query)
            # print(cursor.fetchone()[0]) # COUNT는 데이터가 단 1개이기 때문에 cursor.fetchone() 함수로 (1, ) 튜플을 가져옴
            valid = cursor.fetchone()[0]
            conn.close() 
            if valid == 1: # DB Book 테이블에 같은 번호가 이미 존재
                QMessageBox.warning(self, '저장 경고', '이미 같은 번호의 데이터가 존재합니다!!\n 번호를 변경하세요.')
                return # 함수탈출!!
            else:
                pass
        
        # else:
        #     QMessageBox.about(self,'수정가능','ㅇㅇㅇㅇㅇ')
        #     return

        # 3. 입력 검증 후 DB Book테이블에 삽입 시작
        # bookid, bookName, publisher, price
        if mode == 'I':
            query = f'''INSERT INTO Book
                    VALUES({bookid}, N'{bookName}', N'{publisher}', {price})'''
        elif mode == 'U':
            query = f'''UPDATE Book
                           SET bookname = N'{bookName}'
	                         , publisher = N'{publisher}'
	                         , price = {price}
                         WHERE bookid = {bookid}'''


        conn = pymssql.connect(server = serverName, user = userId, password = userPass, database = dbName, charset = dbCharset)
        cursor = conn.cursor(as_dict = False)    # INSERT는 데이터를 가져오는 것이 아니기 때문에 as_dict는 False이다.
        
        try:
            cursor.execute(query)
            conn.commit() # 저장을 확립
            if mode == 'I':
                QMessageBox.about(self, '저장 성공', '데이터를 저장했습니다.')
            else: 
                QMessageBox.about(self, '수정 성공', '데이터를 수정했습니다.')

        except Exception as e:
            QMessageBox.warning(self, '저장 실패', f'{e}')
            conn.rollback() # 저장이 실패하면 원상복귀
        finally:
            conn.close() # 오류가 나던 안나던, DB는 닫는다.

        self.btnReloadClicked() # 저장 후 조회버튼 클릭 함수 실행

    def btnDelClicked(self):    # 삭제버튼 클릭
        # 삭제기능
        bookid = self.txtBookId.text()
        # Validation Check 필요
        if bookid == None or bookid == '':
            QMessageBox.warning(self, '삭제 경고','책 번호 없이 삭제할 수 없습니다.')
            return
        
        # 삭제 버튼 누를 시, 삭제 여부를 물어봐야함
        re = QMessageBox.question(self, '삭제 여부', '정말로 삭제하시겠습니까?', QMessageBox.Yes | QMessageBox. No)
        if re == QMessageBox.No:
            return

        conn = pymssql.connect(server = serverName, user = userId, password = userPass, database = dbName, charset = dbCharset)
        cursor = conn.cursor(as_dict =False)
        query = f'''DELETE FROM Book
                     WHERE bookid = {bookid}'''

        try:
            cursor.execute(query)
            conn.commit()
            QMessageBox.about(self, '삭제 성공', '데이터를 삭제했습니다.')
        except Exception as e:
            QMessageBox.warning(self,'삭제실패', f'{e}')
            conn.rollback() # 원상복귀
        finally:
            conn.close()

        self.btnReloadClicked()

    def btnReloadClicked(self):    # 조회버튼 클릭
        lstResult = []
        conn = pymssql.connect(server = serverName, user = userId, password = userPass, database = dbName, charset = dbCharset)
        cursor = conn.cursor(as_dict =True)

        query = '''
                SELECT bookid
                     , bookname
                     , publisher
                     , ISNULL(FORMAT(price, '#,#'), '0') AS price -- 원래 price는 숫자이지만 FORMAT을 쓰면 문자가 된다. NULL(None)값이 있으면 0으로 출력되도록 함
                FROM Book							
                '''


        cursor.execute(query)
        for row in cursor:
            # print(f'bookid={row["bookid"]}, bookname={row["bookname"]}, publisher={row["publisher"]}, price={row["price"]}원')
            # dictionary로 만든 결과를 lstResult에 append()
            temp = { 'bookid':row["bookid"], 'bookname':row["bookname"], 'publisher':row["publisher"],'price':row["price"]}
            lstResult.append(temp)

        conn.close() # DB는 접속해서 일이 끝나면 무조건 닫는다
        # print(lstResult)
        self.makeTable(lstResult)

    def makeTable(self, data):  # tblBooks 위젯을 데이터와 컬럼 생성해주는 함수
        self.tblBooks.setColumnCount(4)  # 컬럼(bookid, bookname, publisher, price) 만들기
        self.tblBooks.setRowCount(len(data)) # 조회에서 나온 리스트의 개수로 결정
        self.tblBooks.setHorizontalHeaderLabels(['도서 번호', '도서 제목', '출판사', '정가']) # 표에 컬럼을 설정

        n = 0
        for item in data:
            # print(item) # 디버깅시에 필요할 수 있음
            idItem = QTableWidgetItem(str(item['bookid']))
            idItem.setTextAlignment(Qt.AlignmentFlag.AlignHCenter | Qt.AlignmentFlag.AlignVCenter)  # bookid 값들을 수평중앙, 수직중앙 정렬
            self.tblBooks.setItem(n, 0, idItem) # set(row, column, strtype text), item의 book id가 문자(str타입)가 아니기 때문에 str을 사용해줘야함
            self.tblBooks.setItem(n, 1, QTableWidgetItem(item['bookname'])) # set(row, column, text)
            self.tblBooks.setItem(n, 2, QTableWidgetItem(item['publisher'])) # set(row, column, text)
            priceItem = QTableWidgetItem(str(item['price']))
            priceItem.setTextAlignment(Qt.AlignmentFlag.AlignHCenter | Qt.AlignmentFlag.AlignVCenter) # price 값들을 수평중앙, 수직중앙 정렬
            self.tblBooks.setItem(n, 3, priceItem) # set(row, column, text), item의 price가 문자(str타입)가 아니기 때문에 str을 사용해줘야함

            n += 1
        
        self.tblBooks.setColumnWidth(0, 65)     # 도서 번호 컬럼 넓이
        self.tblBooks.setColumnWidth(1, 230)    # 도서 이름 컬럼 넓이
        self.tblBooks.setColumnWidth(2, 130)    # 출판사 컬럼 넓이
        self.tblBooks.setColumnWidth(3, 80)    # 정가 컬럼 넓이
        
        # 컬럼 더블클릭을 막아주기(수정을 못하도록)
        self.tblBooks.setEditTriggers(QAbstractItemView.NoEditTriggers)

    def tblBooksSelected(self):    # 테이블 위젯 클릭
        rowIndex = self.tblBooks.currentRow() # 현재 마우스로 선택된 행의 인덱스
        # print(rowIndex)
        bookID = self.tblBooks.item(rowIndex, 0).text() # 도서 번호를 가져옴
        bookName = self.tblBooks.item(rowIndex, 1).text() # 도서 제목을 가져옴
        publisher = self.tblBooks.item(rowIndex, 2).text() # 출판사를 가져옴
        price = self.tblBooks.item(rowIndex, 3).text().replace(',','') # 정가를 가져옴. 정가에 있는 쉼표를 제거하여 가져옴
        # print(bookID,bookName,publisher,price) # 디버깅용
        # 지정된 lineEdit(TextBox)에 각각 할당
        self.txtBookId.setText(bookID) 
        self.txtBookName.setText(bookName) 
        self.txtPublisher.setText(publisher) 
        self.txtPrice.setText(price) 
        # 모드를 UPDATE로 변경
        global mode # 전역변수를 내부에서 사용하겠다는 뜻
        mode = 'U'
        # txtBookId를 사용하지 못하게 설정
        self.txtBookId.setEnabled(False)

    # 원래 PyQt에 있는 함수 closeEvent를 재정의(Override)
    def closeEvent(self, event) -> None:
        re = QMessageBox.question(self, '종료여부', '종료하시겠습니까?', QMessageBox.Yes | QMessageBox. No)
        if re == QMessageBox.Yes:
            event.accept()
        else:
            event.ignore() 

    

if __name__ == '__main__':
    app = QApplication(sys.argv)
    inst = qtApp()
    sys.exit(app.exec_())