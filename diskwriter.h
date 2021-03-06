#ifndef DISKWRITER_H
#define DISKWRITER_H

#include <QObject>
#include <QString>
#include <QStringList>
#include <QByteArray>

class DiskWriter : public QObject
{
    Q_OBJECT

public:
    DiskWriter(QObject *parent = 0) : QObject(parent) {}
    virtual ~DiskWriter() {}

public slots:
    void cancelWrite();
    virtual void writeCompressedImageToRemovableDevice(const QString &filename, const QString& device);

signals:
    void bytesWritten(int);
    void syncing();
    void finished();
    void error(const QString& message);

protected:
    volatile bool isCancelled;

    virtual bool open(const QString& device) = 0;
    virtual void close() = 0;
    virtual void sync() = 0;
    virtual bool isOpen() = 0;
    virtual bool write(const QByteArray &data) = 0;
};

#endif // DISKWRITER_H
