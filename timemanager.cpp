#include "timemanager.h"
#include <QDebug>

TimeManager::TimeManager(QObject *parent) : QObject(parent)

{
    selectedHour =0;
    selectedMinute = 0;
}

void TimeManager::setdeadline(int hour ,int minute)
{
    selectedHour=hour;
    selectedMinute=minute;


    emit deadlineset(selectedHour,selectedMinute);
    qDebug() << "Deadline stored - Hour:" << selectedHour << "Minute:"<<selectedMinute;
}
