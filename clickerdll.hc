#include <windows.h>

volatile int clicks = 0;

LRESULT CALLBACK MouseHookCallback(int code, WPARAM wp, LPARAM lp)
{
    if (code >= 0 && wp == WM_LBUTTONDOWN)
    {
        clicks++;
        OutputDebugStringA("click!\n");
    }
    return CallNextHookEx(NULL, code, wp, lp);
}

void StartMouseTracking()
{
    HHOOK hook = SetWindowsHookEx(WH_MOUSE_LL, MouseHookCallback, NULL, 0);
    MSG msg;
    while (GetMessage(&msg, NULL, 0, 0)) { /* this processing cycle */ }
    UnhookWindowsHookEx(hook);
}

extern "C"
__declspec(dllexport) void TrackMouseClicks()
{
    StartMouseTracking();
}
