#ifndef SERIAL_H
#define SERIAL_H

#include <QObject>
#include<QSerialPort>

class Serial : public QObject
{
    Q_OBJECT


public:
    Q_PROPERTY(QString port READ port WRITE setPort NOTIFY portChanged)
    explicit Serial(QObject *parent = 0);

//    Q_INVOKABLE void write(QList<qreal> values);
    Q_INVOKABLE void write(QString values);
    Q_INVOKABLE QString read();
//    Q_INVOKABLE QList<qreal> readFloat();
    Q_INVOKABLE qreal readFloat();

    QString port() { return _port; }

public slots:
    void setPort(const QString& newPort) { _port = newPort; emit portChanged(); }
    void start();
    void stop();
    void dataReady();


signals:
    void portChanged();//const QString& port);
    void error(const QString& msg);
    void readyToRead();




private:
    QString _port;
    QSerialPort *_arduino;

};



#endif // FILEIO_H
