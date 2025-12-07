#include <iostream>
#include <windows.h>

typedef void (*TrackMouseClicksFunc)(void);

int main()
{
    HMODULE dllHandle = LoadLibrary(L"clickerdll.dll");
    if (!dllHandle)
    {
        std::cerr << "Ошибка загрузки DLL." << std::endl;
        return 1;
    }

    TrackMouseClicksFunc trackClicks = reinterpret_cast<TrackMouseClicksFunc>(GetProcAddress(dllHandle, "TrackMouseClicks"));
    if (!trackClicks)
    {
        FreeLibrary(dllHandle);
        std::cerr << "Ошибка получения адреса функции." << std::endl;
        return 1;
    }

    trackClicks();

    return 0;
}
