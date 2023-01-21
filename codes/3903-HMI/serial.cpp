#include "serial.h"
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QByteArray>
#include <QDataStream>
#include <QTextCodec>

Serial::Serial(QObject *parent) :
    QObject(parent)
{
    _arduino = new QSerialPort;
    connect(_arduino, &QSerialPort::readyRead,this, &Serial::dataReady);
}

void Serial::start(){
    _arduino->setPortName(_port);
    _arduino->open(QSerialPort::ReadWrite);
    _arduino->setBaudRate(9600);
    _arduino->setDataBits(QSerialPort::Data8);
    _arduino->setParity(QSerialPort::NoParity);
    _arduino->setStopBits(QSerialPort::OneStop);
    _arduino->setFlowControl(QSerialPort::NoFlowControl);
}

void Serial::stop(){
//    if (_arduino->isOpen()){
//        _arduino->close();
//    }
    _arduino -> close();
}


//void Serial::write(QList<qreal> values){
//    if (_arduino -> isWritable()){
//        _arduino -> write("a");
//        for (float value:values){
////            QByteArray byte_array;
////            QDataStream s(&byte_array, QIODevice::WriteOnly);
////            s << value;
//            QByteArray byte_array = QByteArray::fromRawData(reinterpret_cast<char *>(&f), 4);
//            _arduino -> write(byte_array);
//        }
//    } else {
//        emit error(_port + "is not writeable");
//    }
//}

void Serial::write(QString values){
    if (_arduino -> isWritable()){
        _arduino -> write(values.toUtf8());
    } else {
        emit error(_port + "is not writeable");
    }
}


QString Serial::read(){
    return _arduino->readLine();
}

void Serial::dataReady(){
    if(_arduino->bytesAvailable() < 4){
        return;
    }
    emit readyToRead();
}

//QList<qreal> Serial::readFloat(){
//    qreal data_1, data_2;
//    QList<qreal> data;
////    float data_1;
////    qDebug() << _arduino -> bytesAvailable();
//    QByteArray headerByteArray = _arduino -> read(1);

//    QTextCodec *codec = QTextCodec::QTextCodec::codecForName("UTF-8");
//    QString header = codec->toUnicode(headerByteArray);
////    qDebug() << header << "";
//    if (header != 'a'){
//        return {-1, -1};
//    }
//    QByteArray packet_byte_array_1 = _arduino -> read(4);
//    QDataStream stream(packet_byte_array_1);
//    stream.setFloatingPointPrecision(QDataStream::SinglePrecision);
//    stream.setByteOrder(QDataStream::LittleEndian);
//    stream >> data_1;
////    qDebug() << data_1 << " ";
//    data << data_1;

//    QByteArray packet_byte_array_2 = _arduino -> read(4);
//    QDataStream stream_2(packet_byte_array_2);
//    stream_2.setFloatingPointPrecision(QDataStream::SinglePrecision);
//    stream_2.setByteOrder(QDataStream::LittleEndian);
//    stream_2 >> data_2;
//    data << data_2;
////    qDebug() << data_2 << "\n";

//    return data;
//}

qreal Serial::readFloat(){

    qreal data;
    QByteArray dataByteArray = _arduino -> readAll();
    QDataStream stream(dataByteArray);
    stream.setFloatingPointPrecision(QDataStream::SinglePrecision);
    stream.setByteOrder(QDataStream::LittleEndian);
    stream >> data;
    return data;
}

