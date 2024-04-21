import os
import requests as rs
from requests.auth import HTTPBasicAuth
import json
import logging
from app.schema.nchan import NchanEvent, NchanResponse, ChatroomUsers, CountUpdate
from app.schema.notifications import NotificationMessage, Notification, NotificationType
import logging
import uuid
from json import JSONDecodeError
from typing import List
from app.models.user import Chatrooms


class HttpPublisher:
    def __init__(
        self,
        protocol: str = os.getenv("NCHAN_PROTOCOL"),
        host: str = os.getenv("NCHAN_HOST"),
        port: str = os.getenv("NCHAN_PORT"),
        username: str = os.getenv("NCHAN_USERNAME"),
        password: str = os.getenv("NCHAN_PASSWORD"),
    ):

        self.protocol = protocol
        self.host = host
        self.port = port
        self.username = username
        self.password = password
        self.headers = {"Content-Type": "text/json"}
        self.basic_auth = HTTPBasicAuth(self.username, self.password)
        self.base_url = f"{self.protocol}://{self.host}:{self.port}"
        logging.info(f"NCHAN BASE URL: {self.base_url}")

    def update_user_notifications(self, user_id: str, notifications):
        url = f"{self.base_url}/internal/notifications?channel_id={user_id}"
        logging.warn(f"DELTE HEADERS : {self.headers}")

        if notifications == []:
            self.delete_user_notifications(user_id=user_id)
            return None

        post = rs.post(
            url, headers=self.headers, auth=self.basic_auth, json=notifications
        )

        logging.warn(f"POST EVENTS NOTIFIXATIONS STATUS CODE : {post.status_code}")

    def delete_user_notifications(self, user_id: str):
        url = f"{self.base_url}/internal/notifications/{user_id}/users"

        logging.warn(f"DELTE HEADERS : {self.headers}")
        delete = rs.delete(url, auth=self.basic_auth, headers=self.headers)

        logging.warn(f"Delete EVENTS NOTIFIXATIONS STATUS CODE : {delete.status_code}")

    def count_update(self, event: NchanResponse | str):
        if isinstance(event.data, CountUpdate) is False:
            raise ValueError("Nchan Response data must be Count Update")
        if event.event != "count_update":
            event.event = "count_update"
        else:
            if len(event.data.chatrooms) == 1:
                chatroom_ids_string = f"{event.data.chatrooms[0]},"
            else:
                chatroom_ids = [str(cr.chatroom_id) for cr in event.data.chatrooms]
                chatroom_ids_string = ",".join(chatroom_ids)

            url = f"{self.base_url}/internal/chatroom/{chatroom_ids_string}/count"
            logging.warn(f"NCHAN URL: {url} ")
            post = rs.post(
                url, auth=self.basic_auth, headers=self.headers, json=event.dict()
            )
            if post.status_code not in [200, 201, 202]:
                logging.warn(
                    f"Nchan Status Code was not successful : {post.status_code}"
                )
            else:
                try:
                    return post.json()
                except JSONDecodeError:
                    logging.warn(f"NCHAN RESPONSE WAS NOT JSON : {post.text}")
                    return post.text
                except Exception as e:
                    logging.warn(f"UNKNOWN ERROR : {e}")
                    return post.text

    def publish_chatroom_users(
        self, event: NchanResponse, chatroom_id: uuid.UUID | str
    ):
        if isinstance(event.data, ChatroomUsers) is False:
            raise ValueError("Nchan Response data must be ChatroomUsers")
        if event.event != "user":
            event.event = "user"
        else:
            url = f"{self.base_url}/internal/chatroom/{chatroom_id}/user"
            logging.warn(f"NCHAN URL: {url} ")
            post = rs.post(
                url, auth=self.basic_auth, headers=self.headers, json=event.dict()
            )
            if post.status_code not in [200, 201, 202]:
                logging.warn(
                    f"Nchan Status Code was not successful : {post.status_code}"
                )
            else:
                try:
                    return post.json()
                except JSONDecodeError:
                    logging.warn(f"NCHAN RESPONSE WAS NOT JSON : {post.text}")
                    return post.text
                except Exception as e:
                    logging.warn(f"UNKNOWN ERROR : {e}")
                    return post.text

    def notify_chatroom_users(self, notification: Notification, user_ids: str):
        if isinstance(notification.event, NotificationMessage) is False:
            raise ValueError("Type of Notification must be Message")
        else:
            logging.warn(
                f"\n\n_____________________________\n {user_ids}\n\n **************** \n EVENT : {notification.event.user_id}"
            )

            # Convert the string to a list, remove the specific user ID, and convert it back to a comma-separated string.
            user_ids_list = user_ids.split(",")
            user_ids_list.remove(str(notification.event.user_id))
            user_ids_cleaned = ",".join(user_ids_list)

            user_ids_cleaned = user_ids_cleaned[1 : len(user_ids_cleaned)]
            url = f"{self.base_url}/internal/notifications/{user_ids_cleaned}/users"

            logging.warn(
                f"\n\n------------------------\nCHANNEL ID FOR MULTIPLE NOTIFS : {url}"
            )

            event = {
                "chatroom_id": str(notification.event.chatroom_id),
                "user_id": str(notification.event.user_id),
                "type": "message",
                "text": notification.event.event_text(),
                "id": str(notification.id),
                "created_at": str(notification.created_at),
                "read": False,
            }
            ##### remove the user who sent the message from the notification

            logging.warn(
                f"\n\n\n------------------------\nCHANNEL ID FOR MULTIPLE NOTIFS : {url}"
            )
            post = rs.post(url, auth=self.basic_auth, headers=self.headers, json=event)
            if post.status_code not in [200, 201, 202]:
                logging.warn(
                    f"Nchan Status Code was not successful : {post.status_code}"
                )
            else:
                try:
                    return post.json()
                except JSONDecodeError:
                    logging.warn(f"NCHAN RESPONSE WAS NOT JSON : {post.text}")
                    return post.text
                except Exception as e:
                    logging.warn(f"UNKNOWN ERROR : {e}")
                    return post.text


nchan_client = HttpPublisher()
