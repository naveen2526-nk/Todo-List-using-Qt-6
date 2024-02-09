#ifndef TIMEMANAGER_H
#define TIMEMANAGER_H
#include <QObject>
class TimeManager : public QObject
{
    Q_OBJECT

public:
    explicit TimeManager(QObject *parent =nullptr);

signals:
    void deadlineset (int hour , int minute);

public slots:
    Q_INVOKABLE void setdeadline (int hour, int minute);

private:
    int selectedHour;
    int selectedMinute;
};


#endif // TIMEMANAGER_H
