.class public Lcom/google/xinoshell/utils/SecurityUtil;
.super Ljava/lang/Object;
.source "SecurityUtil.java"


# static fields
.field private static final EMULATOR_FILES:[Ljava/lang/String;

.field private static final EMULATOR_PROPERTIES:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final SU_PATHS:[Ljava/lang/String;

.field private static final TAG:Ljava/lang/String; = "SecurityUtil"


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .line 20
    const/4 v0, 0x7

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "/system/bin/su"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string v1, "/system/xbin/su"

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const-string v1, "/sbin/su"

    const/4 v4, 0x2

    aput-object v1, v0, v4

    const-string v1, "/system/su"

    const/4 v5, 0x3

    aput-object v1, v0, v5

    const-string v1, "/system/bin/.ext/su"

    const/4 v6, 0x4

    aput-object v1, v0, v6

    const-string v1, "/system/usr/we-need-root/su"

    const/4 v7, 0x5

    aput-object v1, v0, v7

    const/4 v1, 0x6

    const-string v8, "/system/xbin/mu"

    aput-object v8, v0, v1

    sput-object v0, Lcom/google/xinoshell/utils/SecurityUtil;->SU_PATHS:[Ljava/lang/String;

    .line 30
    new-array v0, v7, [Ljava/lang/String;

    const-string v1, "/dev/socket/qemud"

    aput-object v1, v0, v2

    const-string v1, "/dev/qemu_pipe"

    aput-object v1, v0, v3

    const-string v1, "/system/lib/libc_malloc_debug_qemu.so"

    aput-object v1, v0, v4

    const-string v1, "/sys/qemu_trace"

    aput-object v1, v0, v5

    const-string v1, "/system/bin/qemu-props"

    aput-object v1, v0, v6

    sput-object v0, Lcom/google/xinoshell/utils/SecurityUtil;->EMULATOR_FILES:[Ljava/lang/String;

    .line 38
    new-instance v0, Lcom/google/xinoshell/utils/SecurityUtil$1;

    invoke-direct {v0}, Lcom/google/xinoshell/utils/SecurityUtil$1;-><init>()V

    sput-object v0, Lcom/google/xinoshell/utils/SecurityUtil;->EMULATOR_PROPERTIES:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static native checkDebuggerNative()Z
.end method

.method private static checkEmulatorBuild()Z
    .locals 4

    .line 153
    sget-object v0, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    const-string v1, "generic"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    .line 154
    const-string v2, "unknown"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    .line 155
    const-string v2, "google_sdk"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    .line 156
    const-string v3, "Emulator"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    .line 157
    const-string v3, "Android SDK built for x86"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    .line 158
    const-string v3, "Genymotion"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Landroid/os/Build;->BRAND:Ljava/lang/String;

    .line 159
    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    :cond_0
    sget-object v0, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    .line 160
    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v0, 0x1

    .line 153
    :goto_1
    return v0
.end method

.method private static checkEmulatorFiles()Z
    .locals 6

    .line 125
    sget-object v0, Lcom/google/xinoshell/utils/SecurityUtil;->EMULATOR_FILES:[Ljava/lang/String;

    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_1

    aget-object v4, v0, v3

    .line 126
    .local v4, "file":Ljava/lang/String;
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 127
    const/4 v0, 0x1

    return v0

    .line 125
    .end local v4    # "file":Ljava/lang/String;
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 130
    :cond_1
    return v2
.end method

.method private static checkEmulatorHardware()Z
    .locals 2

    .line 164
    sget-object v0, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    .line 165
    .local v0, "hardware":Ljava/lang/String;
    const-string v1, "goldfish"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "ranchu"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "vbox86"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v1, 0x1

    :goto_1
    return v1
.end method

.method private static checkEmulatorProps()Z
    .locals 9

    .line 135
    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lcom/google/xinoshell/utils/SecurityUtil;->EMULATOR_PROPERTIES:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 136
    .local v2, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v3

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/String;

    const-string v5, "/system/bin/getprop"

    aput-object v5, v4, v0

    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    const/4 v6, 0x1

    aput-object v5, v4, v6

    invoke-virtual {v3, v4}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v3

    .line 137
    .local v3, "process":Ljava/lang/Process;
    new-instance v4, Ljava/util/Scanner;

    invoke-virtual {v3}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 138
    .local v4, "scanner":Ljava/util/Scanner;
    invoke-virtual {v4}, Ljava/util/Scanner;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 139
    invoke-virtual {v4}, Ljava/util/Scanner;->next()Ljava/lang/String;

    move-result-object v5

    .line 140
    .local v5, "value":Ljava/lang/String;
    invoke-virtual {v5}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/CharSequence;

    invoke-virtual {v7, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 141
    return v6

    .line 144
    .end local v5    # "value":Ljava/lang/String;
    :cond_0
    invoke-virtual {v4}, Ljava/util/Scanner;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 145
    .end local v2    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v3    # "process":Ljava/lang/Process;
    .end local v4    # "scanner":Ljava/util/Scanner;
    goto :goto_0

    .line 148
    :cond_1
    goto :goto_1

    .line 146
    :catch_0
    move-exception v1

    .line 147
    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "SecurityUtil"

    const-string v3, "Error checking emulator props"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 149
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_1
    return v0
.end method

.method private static native checkRootNative()Z
.end method

.method private static checkRootProps()Z
    .locals 13

    .line 86
    const-string v0, "ro.secure"

    sget-object v1, Landroid/os/Build;->TAGS:Ljava/lang/String;

    .line 87
    .local v1, "buildTags":Ljava/lang/String;
    const/4 v2, 0x1

    if-eqz v1, :cond_0

    const-string v3, "test-keys"

    invoke-virtual {v1, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 88
    return v2

    .line 92
    :cond_0
    const/4 v3, 0x3

    const/4 v4, 0x0

    :try_start_0
    new-array v3, v3, [Ljava/lang/String;

    const-string v5, "ro.debuggable"

    aput-object v5, v3, v4

    aput-object v0, v3, v2

    const-string v5, "service.adb.root"

    const/4 v6, 0x2

    aput-object v5, v3, v6

    .line 98
    .local v3, "props":[Ljava/lang/String;
    array-length v5, v3

    move v7, v4

    :goto_0
    if-ge v7, v5, :cond_3

    aget-object v8, v3, v7

    .line 99
    .local v8, "prop":Ljava/lang/String;
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v9

    new-array v10, v6, [Ljava/lang/String;

    const-string v11, "/system/bin/getprop"

    aput-object v11, v10, v4

    aput-object v8, v10, v2

    invoke-virtual {v9, v10}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v9

    .line 100
    .local v9, "process":Ljava/lang/Process;
    new-instance v10, Ljava/util/Scanner;

    invoke-virtual {v9}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 101
    .local v10, "scanner":Ljava/util/Scanner;
    invoke-virtual {v10}, Ljava/util/Scanner;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_2

    .line 102
    invoke-virtual {v10}, Ljava/util/Scanner;->next()Ljava/lang/String;

    move-result-object v11

    .line 103
    .local v11, "value":Ljava/lang/String;
    const-string v12, "1"

    invoke-virtual {v12, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-nez v12, :cond_1

    const-string v12, "0"

    invoke-virtual {v12, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_2

    invoke-virtual {v8, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_2

    .line 104
    :cond_1
    return v2

    .line 107
    .end local v11    # "value":Ljava/lang/String;
    :cond_2
    invoke-virtual {v10}, Ljava/util/Scanner;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 98
    .end local v8    # "prop":Ljava/lang/String;
    .end local v9    # "process":Ljava/lang/Process;
    .end local v10    # "scanner":Ljava/util/Scanner;
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 111
    .end local v3    # "props":[Ljava/lang/String;
    :cond_3
    goto :goto_1

    .line 109
    :catch_0
    move-exception v0

    .line 110
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "SecurityUtil"

    const-string v3, "Error checking root props"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 112
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return v4
.end method

.method private static checkSuBinary()Z
    .locals 6

    .line 56
    sget-object v0, Lcom/google/xinoshell/utils/SecurityUtil;->SU_PATHS:[Ljava/lang/String;

    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_1

    aget-object v4, v0, v3

    .line 57
    .local v4, "path":Ljava/lang/String;
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 58
    const/4 v0, 0x1

    return v0

    .line 56
    .end local v4    # "path":Ljava/lang/String;
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 61
    :cond_1
    return v2
.end method

.method private static checkSuperuserApk(Landroid/content/Context;)Z
    .locals 6
    .param p0, "context"    # Landroid/content/Context;

    .line 66
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 67
    .local v0, "pm":Landroid/content/pm/PackageManager;
    const/16 v1, 0x80

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getInstalledApplications(I)Ljava/util/List;

    move-result-object v1

    .line 68
    .local v1, "packages":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ApplicationInfo;>;"
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ApplicationInfo;

    .line 69
    .local v3, "packageInfo":Landroid/content/pm/ApplicationInfo;
    iget-object v4, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const-string v5, "com.noshufou.android.su"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const-string v5, "com.noshufou.android.su.elite"

    .line 70
    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const-string v5, "eu.chainfire.supersu"

    .line 71
    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const-string v5, "com.koushikdutta.superuser"

    .line 72
    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const-string v5, "com.thirdparty.superuser"

    .line 73
    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const-string v5, "com.yellowes.su"

    .line 74
    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const-string v5, "com.topjohnwu.magisk"

    .line 75
    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v4, :cond_0

    goto :goto_1

    .line 78
    .end local v3    # "packageInfo":Landroid/content/pm/ApplicationInfo;
    :cond_0
    goto :goto_0

    .line 76
    .restart local v3    # "packageInfo":Landroid/content/pm/ApplicationInfo;
    :cond_1
    :goto_1
    const/4 v2, 0x1

    return v2

    .line 81
    .end local v0    # "pm":Landroid/content/pm/PackageManager;
    .end local v1    # "packages":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ApplicationInfo;>;"
    .end local v3    # "packageInfo":Landroid/content/pm/ApplicationInfo;
    :cond_2
    goto :goto_2

    .line 79
    :catch_0
    move-exception v0

    .line 80
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "SecurityUtil"

    const-string v2, "Error checking for superuser APK"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 82
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_2
    const/4 v0, 0x0

    return v0
.end method

.method private static checkTracerPid()Z
    .locals 4

    .line 343
    const-string v0, "TracerPid:"

    :try_start_0
    new-instance v1, Ljava/util/Scanner;

    new-instance v2, Ljava/io/File;

    const-string v3, "/proc/self/status"

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v1, v2}, Ljava/util/Scanner;-><init>(Ljava/io/File;)V

    .line 344
    .local v1, "scanner":Ljava/util/Scanner;
    :goto_0
    invoke-virtual {v1}, Ljava/util/Scanner;->hasNextLine()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 345
    invoke-virtual {v1}, Ljava/util/Scanner;->nextLine()Ljava/lang/String;

    move-result-object v2

    .line 346
    .local v2, "line":Ljava/lang/String;
    invoke-virtual {v2, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 347
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {v2, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 348
    .local v0, "tracerPid":Ljava/lang/String;
    const-string v3, "0"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    xor-int/lit8 v3, v3, 0x1

    return v3

    .line 350
    .end local v0    # "tracerPid":Ljava/lang/String;
    .end local v2    # "line":Ljava/lang/String;
    :cond_0
    goto :goto_0

    .line 351
    :cond_1
    invoke-virtual {v1}, Ljava/util/Scanner;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 354
    .end local v1    # "scanner":Ljava/util/Scanner;
    goto :goto_1

    .line 352
    :catch_0
    move-exception v0

    .line 353
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "SecurityUtil"

    const-string v2, "Error checking TracerPid"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 355
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    const/4 v0, 0x0

    return v0
.end method

.method public static isAppRepackaged(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "signature"    # Ljava/lang/String;

    .line 224
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 225
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x40

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    iget-object v1, v1, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    .line 224
    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Landroid/content/pm/Signature;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    .line 226
    invoke-virtual {v1}, Landroid/content/pm/Signature;->toCharsString()Ljava/lang/String;

    move-result-object v1

    .line 228
    .local v1, "currentSignature":Ljava/lang/String;
    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    xor-int/2addr v0, v2

    return v0

    .line 229
    .end local v1    # "currentSignature":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 230
    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "SecurityUtil"

    const-string v3, "Error checking app signature"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 231
    return v0
.end method

.method public static isCustomRom()Z
    .locals 10

    .line 416
    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Landroid/os/Build;->TAGS:Ljava/lang/String;

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    sget-object v1, Landroid/os/Build;->TAGS:Ljava/lang/String;

    const-string v3, "test-keys"

    invoke-virtual {v1, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 417
    return v2

    .line 420
    :cond_0
    const/4 v1, 0x6

    new-array v1, v1, [Ljava/lang/String;

    const-string v3, "ro.cm.build.version"

    aput-object v3, v1, v0

    const-string v3, "ro.lineage.build.version"

    aput-object v3, v1, v2

    const-string v3, "ro.pa.version"

    const/4 v4, 0x2

    aput-object v3, v1, v4

    const-string v3, "ro.paranoid.version"

    const/4 v5, 0x3

    aput-object v3, v1, v5

    const-string v3, "ro.omni.version"

    const/4 v5, 0x4

    aput-object v3, v1, v5

    const-string v3, "ro.rr.version"

    const/4 v5, 0x5

    aput-object v3, v1, v5

    .line 429
    .local v1, "customRomProps":[Ljava/lang/String;
    array-length v3, v1

    move v5, v0

    :goto_0
    if-ge v5, v3, :cond_2

    aget-object v6, v1, v5

    .line 430
    .local v6, "prop":Ljava/lang/String;
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v7

    new-array v8, v4, [Ljava/lang/String;

    const-string v9, "/system/bin/getprop"

    aput-object v9, v8, v0

    aput-object v6, v8, v2

    invoke-virtual {v7, v8}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v7

    .line 431
    .local v7, "process":Ljava/lang/Process;
    new-instance v8, Ljava/util/Scanner;

    invoke-virtual {v7}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 432
    .local v8, "scanner":Ljava/util/Scanner;
    invoke-virtual {v8}, Ljava/util/Scanner;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_1

    .line 433
    return v2

    .line 435
    :cond_1
    invoke-virtual {v8}, Ljava/util/Scanner;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 429
    .end local v6    # "prop":Ljava/lang/String;
    .end local v7    # "process":Ljava/lang/Process;
    .end local v8    # "scanner":Ljava/util/Scanner;
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 439
    .end local v1    # "customRomProps":[Ljava/lang/String;
    :cond_2
    goto :goto_1

    .line 437
    :catch_0
    move-exception v1

    .line 438
    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "SecurityUtil"

    const-string v3, "Error checking custom ROM"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 440
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_1
    return v0
.end method

.method public static isDebug(Landroid/content/Context;)Z
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 207
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget v0, v0, Landroid/content/pm/ApplicationInfo;->flags:I

    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static isDebuggerConnected()Z
    .locals 1

    .line 336
    invoke-static {}, Landroid/os/Debug;->isDebuggerConnected()Z

    move-result v0

    if-nez v0, :cond_1

    .line 337
    invoke-static {}, Lcom/google/xinoshell/utils/SecurityUtil;->checkTracerPid()Z

    move-result v0

    if-nez v0, :cond_1

    .line 338
    invoke-static {}, Lcom/google/xinoshell/utils/SecurityUtil;->checkDebuggerNative()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 336
    :goto_1
    return v0
.end method

.method public static isDeviceRooted(Landroid/content/Context;)Z
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 52
    invoke-static {}, Lcom/google/xinoshell/utils/SecurityUtil;->checkSuBinary()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p0}, Lcom/google/xinoshell/utils/SecurityUtil;->checkSuperuserApk(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lcom/google/xinoshell/utils/SecurityUtil;->checkRootProps()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public static isEmulator()Z
    .locals 1

    .line 121
    invoke-static {}, Lcom/google/xinoshell/utils/SecurityUtil;->checkEmulatorFiles()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lcom/google/xinoshell/utils/SecurityUtil;->checkEmulatorProps()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lcom/google/xinoshell/utils/SecurityUtil;->checkEmulatorBuild()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lcom/google/xinoshell/utils/SecurityUtil;->checkEmulatorHardware()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public static isMagiskPresent()Z
    .locals 7

    .line 365
    const/4 v0, 0x1

    :try_start_0
    const-string v1, "com.topjohnwu.magisk.MagiskManager"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 366
    .local v1, "magiskClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    if-eqz v1, :cond_0

    .line 367
    return v0

    .line 371
    .end local v1    # "magiskClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_0
    goto :goto_0

    .line 369
    :catch_0
    move-exception v1

    .line 374
    :goto_0
    const/4 v1, 0x7

    new-array v1, v1, [Ljava/lang/String;

    const-string v2, "/sbin/.magisk"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "/sbin/magisk"

    aput-object v2, v1, v0

    const/4 v2, 0x2

    const-string v4, "/sbin/magiskhide"

    aput-object v4, v1, v2

    const/4 v2, 0x3

    const-string v4, "/cache/.disable_magisk"

    aput-object v4, v1, v2

    const/4 v2, 0x4

    const-string v4, "/cache/magisk.log"

    aput-object v4, v1, v2

    const/4 v2, 0x5

    const-string v4, "/cache/magisk_debug.log"

    aput-object v4, v1, v2

    const/4 v2, 0x6

    const-string v4, "/data/adb/magisk"

    aput-object v4, v1, v2

    .line 384
    .local v1, "magiskFiles":[Ljava/lang/String;
    array-length v2, v1

    move v4, v3

    :goto_1
    if-ge v4, v2, :cond_2

    aget-object v5, v1, v4

    .line 385
    .local v5, "file":Ljava/lang/String;
    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v6

    if-eqz v6, :cond_1

    .line 386
    return v0

    .line 384
    .end local v5    # "file":Ljava/lang/String;
    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 390
    :cond_2
    return v3
.end method

.method public static isMockLocationEnabled(Landroid/content/Context;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .line 323
    nop

    .line 324
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mock_location"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 325
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    .line 324
    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public static isSELinuxEnforcing()Z
    .locals 4

    .line 398
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    const-string v1, "getenforce"

    invoke-virtual {v0, v1}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v0

    .line 399
    .local v0, "process":Ljava/lang/Process;
    new-instance v1, Ljava/util/Scanner;

    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 400
    .local v1, "scanner":Ljava/util/Scanner;
    invoke-virtual {v1}, Ljava/util/Scanner;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 401
    invoke-virtual {v1}, Ljava/util/Scanner;->next()Ljava/lang/String;

    move-result-object v2

    .line 402
    .local v2, "result":Ljava/lang/String;
    const-string v3, "Enforcing"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    return v3

    .line 404
    .end local v2    # "result":Ljava/lang/String;
    :cond_0
    invoke-virtual {v1}, Ljava/util/Scanner;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 407
    .end local v0    # "process":Ljava/lang/Process;
    .end local v1    # "scanner":Ljava/util/Scanner;
    goto :goto_0

    .line 405
    :catch_0
    move-exception v0

    .line 406
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "SecurityUtil"

    const-string v2, "Error checking SELinux"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 408
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method public static isScreenMirrored(Landroid/content/Context;)Z
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 240
    nop

    .line 241
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "display_size_forced"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    :cond_0
    return v2
.end method

.method public static isUsbDebuggingEnabled(Landroid/content/Context;)Z
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 214
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "adb_enabled"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    move v2, v1

    :cond_0
    return v2
.end method

.method public static isUsingProxy(Landroid/content/Context;)Z
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 191
    nop

    .line 192
    const-string v0, "http.proxyHost"

    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 193
    .local v0, "proxyHost":Ljava/lang/String;
    const-string v1, "http.proxyPort"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 194
    .local v1, "portStr":Ljava/lang/String;
    if-eqz v1, :cond_0

    move-object v2, v1

    goto :goto_0

    :cond_0
    const-string v2, "-1"

    :goto_0
    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 195
    .local v1, "proxyPort":I
    nop

    .line 200
    if-eqz v0, :cond_1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    const/4 v2, 0x1

    goto :goto_1

    :cond_1
    const/4 v2, 0x0

    :goto_1
    return v2
.end method

.method public static isVirtualEnvironment(Landroid/content/Context;)Z
    .locals 9
    .param p0, "context"    # Landroid/content/Context;

    .line 281
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 282
    .local v1, "pm":Landroid/content/pm/PackageManager;
    const/4 v2, 0x5

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "com.lbe.parallel"

    aput-object v3, v2, v0

    const-string v3, "com.excelliance.dualaid"

    const/4 v4, 0x1

    aput-object v3, v2, v4

    const-string v3, "com.parallel.space"

    const/4 v5, 0x2

    aput-object v3, v2, v5

    const-string v3, "com.ludashi.virtual"

    const/4 v6, 0x3

    aput-object v3, v2, v6

    const-string v3, "com.parallel.apps"

    const/4 v7, 0x4

    aput-object v3, v2, v7

    .line 290
    .local v2, "virtualEnvPackages":[Ljava/lang/String;
    array-length v3, v2

    if-lez v3, :cond_0

    aget-object v3, v2, v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 292
    .local v3, "pkg":Ljava/lang/String;
    :try_start_1
    invoke-virtual {v1, v3, v4}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 293
    return v4

    .line 294
    :catch_0
    move-exception v4

    .line 295
    .local v4, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :try_start_2
    new-instance v5, Ljava/lang/RuntimeException;

    invoke-direct {v5, v4}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "context":Landroid/content/Context;
    throw v5

    .line 299
    .end local v3    # "pkg":Ljava/lang/String;
    .end local v4    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    .restart local p0    # "context":Landroid/content/Context;
    :cond_0
    new-array v3, v6, [Ljava/lang/String;

    const-string v6, "/data/data/com.lbe.parallel"

    aput-object v6, v3, v0

    const-string v6, "/data/data/com.excelliance.dualaid"

    aput-object v6, v3, v4

    const-string v6, "/data/data/com.parallel.space"

    aput-object v6, v3, v5

    .line 305
    .local v3, "virtualEnvFiles":[Ljava/lang/String;
    array-length v5, v3

    move v6, v0

    :goto_0
    if-ge v6, v5, :cond_2

    aget-object v7, v3, v6

    .line 306
    .local v7, "file":Ljava/lang/String;
    new-instance v8, Ljava/io/File;

    invoke-direct {v8, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8}, Ljava/io/File;->exists()Z

    move-result v8
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    if-eqz v8, :cond_1

    .line 307
    return v4

    .line 305
    .end local v7    # "file":Ljava/lang/String;
    :cond_1
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 313
    .end local v1    # "pm":Landroid/content/pm/PackageManager;
    .end local v2    # "virtualEnvPackages":[Ljava/lang/String;
    .end local v3    # "virtualEnvFiles":[Ljava/lang/String;
    :cond_2
    goto :goto_1

    .line 311
    :catch_1
    move-exception v1

    .line 312
    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "SecurityUtil"

    const-string v3, "Error checking virtual environment"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 315
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_1
    return v0
.end method

.method public static isVpnActive()Z
    .locals 4

    .line 173
    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Ljava/net/NetworkInterface;->getNetworkInterfaces()Ljava/util/Enumeration;

    move-result-object v1

    .line 174
    invoke-interface {v1}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/net/NetworkInterface;

    .line 175
    invoke-virtual {v1}, Ljava/net/NetworkInterface;->getDisplayName()Ljava/lang/String;

    move-result-object v1

    .line 176
    .local v1, "iface":Ljava/lang/String;
    const-string v2, "tun"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "ppp"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "pptp"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v2, :cond_1

    :cond_0
    const/4 v0, 0x1

    :cond_1
    return v0

    .line 177
    .end local v1    # "iface":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 178
    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "SecurityUtil"

    const-string v3, "Error checking VPN"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 179
    return v0
.end method

.method public static isXposedInstalled()Z
    .locals 5

    .line 252
    const/4 v0, 0x1

    :try_start_0
    const-string v1, "de.robv.android.xposed.XposedBridge"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 253
    .local v1, "xposedBridge":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    if-eqz v1, :cond_0

    .line 254
    return v0

    .line 257
    .end local v1    # "xposedBridge":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_0
    goto :goto_0

    .line 256
    :catch_0
    move-exception v1

    .line 260
    :goto_0
    :try_start_1
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v1

    const-string v2, "su -c ls /data/app/"

    invoke-virtual {v1, v2}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v1

    .line 261
    .local v1, "process":Ljava/lang/Process;
    new-instance v2, Ljava/util/Scanner;

    invoke-virtual {v1}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 262
    .local v2, "scanner":Ljava/util/Scanner;
    :goto_1
    invoke-virtual {v2}, Ljava/util/Scanner;->hasNextLine()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 263
    invoke-virtual {v2}, Ljava/util/Scanner;->nextLine()Ljava/lang/String;

    move-result-object v3

    .line 264
    .local v3, "line":Ljava/lang/String;
    const-string v4, "xposed"

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_2

    const-string v4, "Xposed"

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    goto :goto_2

    .line 267
    .end local v3    # "line":Ljava/lang/String;
    :cond_1
    goto :goto_1

    .line 265
    .restart local v3    # "line":Ljava/lang/String;
    :cond_2
    :goto_2
    return v0

    .line 268
    .end local v3    # "line":Ljava/lang/String;
    :cond_3
    invoke-virtual {v2}, Ljava/util/Scanner;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 271
    .end local v1    # "process":Ljava/lang/Process;
    .end local v2    # "scanner":Ljava/util/Scanner;
    nop

    .line 273
    const/4 v0, 0x0

    return v0

    .line 269
    :catch_1
    move-exception v0

    .line 270
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method
