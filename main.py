import sys
import threading
from time import strftime, gmtime, localtime, sleep

from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtQuick import QQuickWindow
from PyQt6.QtCore import QObject, pyqtSignal, pyqtSlot
from PyQt6.QtWidgets import QApplication

from classes.CustomDialog import CustomDialog

class Backend(QObject):
    def __init__(self):
        QObject.__init__(self)
    
    zuluTime = pyqtSignal(str, arguments=['zuluTimeUpdater'])
    localTime = pyqtSignal(str, arguments=['localTimeUpdater'])
    
    def zuluTimeUpdater(self, zulu_time):
        self.zuluTime.emit(zulu_time)

    def localTimeUpdater(self, local_time):
        self.localTime.emit(local_time)
    
    def bootUp(self):
        t_thread = threading.Thread(target=self._bootUp)
        t_thread.daemon = True
        t_thread.start()
    
    def _bootUp(self):
        while True:
            self.zuluTimeUpdater(strftime("%Y-%m-%d %H:%M:%S", gmtime()) + 'Z')
            self.localTimeUpdater(strftime("%Y-%m-%d %H:%M:%S", localtime()))
            sleep(1)
    
    @pyqtSlot()
    def exit_app(self):
        app.quit()

    @pyqtSlot()
    def openDialog(self):
        dlg = CustomDialog()
        dlg.exec()
    

QQuickWindow.setSceneGraphBackend('software')

app = QApplication(sys.argv)

engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('./src/UI/main.qml')
back_end = Backend()
engine.rootObjects()[0].setProperty('backend', back_end)
ctx = engine.rootContext()

back_end.bootUp()

sys.exit(app.exec())