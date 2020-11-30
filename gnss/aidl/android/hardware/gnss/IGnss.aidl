/*
 * Copyright (C) 2020 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package android.hardware.gnss;

import android.hardware.gnss.IGnssCallback;
import android.hardware.gnss.IGnssPowerIndication;
import android.hardware.gnss.IGnssPsds;
import android.hardware.gnss.IGnssConfiguration;

/**
 * Represents the standard GNSS (Global Navigation Satellite System) interface.
 */
@VintfStability
interface IGnss {

    /**
     * All GNSS Binder calls may return a ServiceSpecificException with the following error
     * codes.
     */
    const int ERROR_INVALID_ARGUMENT = 1;

    /** Bit mask indicating a valid timestampNs is stored in the ElapsedRealtime parcelable. */
    const int ELAPSED_REALTIME_HAS_TIMESTAMP_NS = 1 << 0;

    /**
     * Bit mask indicating a valid timeUncertaintyNs is stored in the ElapsedRealtime parcelable.
     */
    const int ELAPSED_REALTIME_HAS_TIME_UNCERTAINTY_NS = 1 << 1;

    /**
     * Opens the interface and provides the callback routines to the implementation of this
     * interface.
     *
     * The framework calls this method to instruct the GPS engine to prepare for serving requests
     * from the framework. The GNSS HAL implementation must respond to all GNSS requests from the
     * framework upon successful return from this method until cleanup() method is called to
     * close this interface.
     *
     * @param callback Callback interface for IGnss.
     */
    void setCallback(in IGnssCallback callback);

    /**
     * Closes the interface.
     *
     * The close() method is called by the framework to tell the GNSS HAL implementation to
     * clear the callback and not expect any GNSS requests in the immediate future - e.g. this may
     * be called when location is disabled by a user setting or low battery conditions. The GNSS HAL
     * implementation must immediately stop responding to any existing requests until the
     * setCallback() method is called again and the requests are re-initiated by the framework.
     *
     * After this method is called, the GNSS HAL implementation may choose to modify GNSS hardware
     * states to save power. It is expected that when setCallback() method is called again to
     * reopen this interface, to serve requests, there may be some minor delays in GNSS response
     * requests as hardware readiness states are restored, not to exceed those that occur on normal
     * device boot up.
     */
    void close();

    /**
     * This method returns the IGnssPsds interface.
     *
     * @return Handle to the IGnssPsds interface.
     */
    IGnssPsds getExtensionPsds();

    /**
     * This method returns the IGnssConfiguration interface.
     *
     * @return Handle to the IGnssConfiguration interface.
     */
    IGnssConfiguration getExtensionGnssConfiguration();

    /**
     * This method returns the IGnssPowerIndication interface.
     *
     * @return Handle to the IGnssPowerIndication interface.
     */
    IGnssPowerIndication getExtensionGnssPowerIndication();
}
