--
-- PostgreSQL database dump
--

\restrict raNERaNM2B5SNwG1fTB0g4DaW8zplT5gIZzVPiPvN2bo0AHig72ocSxRvRQWnNC

-- Dumped from database version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: email_templates; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (1, 'COPYEDIT_REQUEST', 1, 'DISCUSSION_NOTIFICATION_COPYEDITING');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (2, 'EDITOR_ASSIGN_SUBMISSION', 1, 'DISCUSSION_NOTIFICATION_SUBMISSION');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (3, 'EDITOR_ASSIGN_REVIEW', 1, 'DISCUSSION_NOTIFICATION_REVIEW');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (4, 'EDITOR_ASSIGN_PRODUCTION', 1, 'DISCUSSION_NOTIFICATION_PRODUCTION');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (5, 'LAYOUT_REQUEST', 1, 'DISCUSSION_NOTIFICATION_PRODUCTION');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (6, 'LAYOUT_COMPLETE', 1, 'DISCUSSION_NOTIFICATION_PRODUCTION');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (7, 'COPYEDIT_REQUEST', 2, 'DISCUSSION_NOTIFICATION_COPYEDITING');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (8, 'EDITOR_ASSIGN_SUBMISSION', 2, 'DISCUSSION_NOTIFICATION_SUBMISSION');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (9, 'EDITOR_ASSIGN_REVIEW', 2, 'DISCUSSION_NOTIFICATION_REVIEW');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (10, 'EDITOR_ASSIGN_PRODUCTION', 2, 'DISCUSSION_NOTIFICATION_PRODUCTION');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (11, 'LAYOUT_REQUEST', 2, 'DISCUSSION_NOTIFICATION_PRODUCTION');
INSERT INTO public.email_templates (email_id, email_key, context_id, alternate_to) VALUES (12, 'LAYOUT_COMPLETE', 2, 'DISCUSSION_NOTIFICATION_PRODUCTION');


--
-- Data for Name: email_templates_default_data; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (1, 'PASSWORD_RESET_CONFIRM', 'en', 'Password Reset Confirm', 'Password Reset Confirmation', 'We have received a request to reset your password for the {$siteTitle} web site.<br />
<br />
If you did not make this request, please ignore this email and your password will not be changed. If you wish to reset your password, click on the below URL.<br />
<br />
Reset my password: {$passwordResetUrl}<br />
<br />
{$siteContactName}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (2, 'PASSWORD_RESET_CONFIRM', 'id', 'Konfirmasi Pengaturan Ulang Password', 'Konfirmasi Reset Sandi', 'Kami menerima permintaan reset sandi untuk akun Anda di website {$siteTitle}.<br />
<br />
Jika Anda tidak merasa mengajukan permintaan ini, abaikan pesan ini dan sandi Anda tidak akan diubah. Jika Anda memang ingin melakukan reset sandi, klik tautan berikut ini.<br />
<br />
Reset sandi saya: {$passwordResetUrl}<br />
<br />
{$siteContactName}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (3, 'USER_REGISTER', 'en', 'User Created', 'Journal Registration', '{$recipientName}<br />
<br />
You have now been registered as a user with {$contextName}. We have included your username and password in this email, which are needed for all work with this journal through its website. At any point, you can ask to be removed from the journal''s list of users by contacting me.<br />
<br />
Username: {$recipientUsername}<br />
Password: {$password}<br />
<br />
Thank you,<br />
{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (4, 'USER_REGISTER', 'id', 'Pengguna Dibuat', 'Registrasi Jurnal', '{$recipientName}<br />
<br />
Anda sekarang telah terdaftar sebagai pengguna di {$contextName}. Kami sertakan nama pengguna dan sandi Anda di email ini, keduanya diperlukan untuk semua kegiatan melalui website jurnal ini. Anda dapat keluar dari daftar pengguna jurnal kapan saja dengan menghubungi kami.<br />
<br />
Nama pengguna: {$recipientUsername}<br />
Sandi: {$password}<br />
<br />
Terimakasih,<br />
{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (5, 'USER_VALIDATE_CONTEXT', 'en', 'Validate Email (Journal Registration)', 'Validate Your Account', '{$recipientName}<br />
<br />
You have created an account with {$contextName}, but before you can start using it, you need to validate your email account. To do this, simply follow the link below:<br />
<br />
{$activateUrl}<br />
<br />
Thank you,<br />
{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (6, 'USER_VALIDATE_CONTEXT', 'id', 'validasi Email (Registrasi Jurnal)', 'Validasi Akun Anda', '{$recipientName}<br />
<br />
Anda telah membuat akun di {$contextName}. Sebelum dapat menggunakannya, Anda perlu melakukan validasi akun email. Untuk melakukannya, klik tautan berikut ini:<br />
<br />
{$activateUrl}<br />
<br />
Terimakasih,<br />
{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (7, 'USER_VALIDATE_SITE', 'en', 'Validate Email (Site)', 'Validate Your Account', '{$recipientName}<br />
<br />
You have created an account with {$siteTitle}, but before you can start using it, you need to validate your email account. To do this, simply follow the link below:<br />
<br />
{$activateUrl}<br />
<br />
Thank you,<br />
{$siteSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (8, 'USER_VALIDATE_SITE', 'id', 'Memvalidasi Email (Situs)', 'Validasi Akun Kamu', '{$recipientName}<br />
<br />
Kamu berhasi membuat akun paaa {$siteTitle}, tapi sebelum bisa menggunakannya, validasi akun email kamu terlebih dahulu dengan mengikuti petunjuk pada tautan berikut:<br />
<br />
{$activateUrl}<br />
<br />
Terima kasih,<br />
{$siteSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (9, 'REVIEWER_REGISTER', 'en', 'Reviewer Register', 'Registration as Reviewer with {$contextName}', '<p>Dear {$recipientName},</p><p>In light of your expertise, we have registered your name in the reviewer database for {$contextName}. This does not entail any form of commitment on your part, but simply enables us to approach you with a submission to possibly review. On being invited to review, you will have an opportunity to see the title and abstract of the paper in question, and you''ll always be in a position to accept or decline the invitation. You can also ask at any point to have your name removed from this reviewer list.</p><p>We are providing you with a username and password, which is used in all interactions with the journal through its website. You may wish, for example, to update your profile, including your reviewing interests.</p><p>Username: {$recipientUsername}<br />Password: {$password}</p><p>Thank you,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (10, 'REVIEWER_REGISTER', 'id', 'Mendaftarkan Reviewer', 'Registrasi sebagai Reviewer di {$contextName}', '<p>Yth {$recipientName},</p><p>Dengan mempertimbangkan keahlian Anda, kami memasukkan nama Anda dalam database reviewer di {$contextName}. THal ini tidak bersifat mengikat, hanya sekedar memudahkan kami untuk mengundang Anda untuk melakukan review terhadap suatu naskah. Ketika memperoleh undangan untuk melakukan review suatu naskah, Anda dapat melihat judul dan abstrak naskah tersebut, dan Anda berhak menentukan apakah akan menerima atau menolak undangan tersebut. Anda juga dapat meminta nama Anda dihapus dari daftar reviewer.</p><p>Kami menyertakan nama pengguna dan sandi Anda, yang digunakan dalam semua interaksi dengan jurnal melalui website. Anda dapat melakukan update profil, termasuk minat review Anda.</p><p>Username: {$recipientUsername}<br />Password: {$password}</p><p>Terima kasih,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (11, 'ISSUE_PUBLISH_NOTIFY', 'en', 'Issue Published Notify', 'Just published: {$issueIdentification} of {$contextName}', '<p>Dear {$recipientName},</p><p>We are pleased to announce the publication of <a href="{$issueUrl}">{$issueIdentification}</a> of {$contextName}.  We invite you to read and share this work with your scholarly community.</p><p>Many thanks to our authors, reviewers, and editors for their valuable contributions, and to our readers for your continued interest.</p><div>{$issueToc}</div><p>Thank you,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (12, 'ISSUE_PUBLISH_NOTIFY', 'id', 'Notifikasi Terbitan', 'Terbitan baru telah tersedia: {$issueIdentification} dari {$contextName}', '<p>Yang terhormat {$recipientName},</p><p>Dengan senang hati kami umumkan penerbitan <a href="{$issueUrl}">{$issueIdentification}</a> karya {$contextName}. Kami mengundang Anda untuk membaca dan berbagi karya ini dengan komunitas akademis Anda.</p><p>Terima kasih banyak kepada para penulis, pengulas, dan editor kami atas kontribusi mereka yang berharga, dan kepada para pembaca kami atas minat Anda yang berkelanjutan.</p><div>{$issueToc}</div><p>Terima kasih,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (13, 'SUBMISSION_ACK', 'en', 'Submission Confirmation', 'Thank you for your submission to {$contextName}', '<p>Dear {$recipientName},</p><p>Thank you for your submission to {$contextName}. We have received your submission, "{$submissionTitle}", and a member of our editorial team will see it soon. You will be sent an email when an initial decision is made, and we may contact you for further information.</p><p>You can view your submission and track its progress through the editorial process at the following location:</p><p>Submission URL: {$authorSubmissionUrl}</p><p>If you have been logged out, you can login again with the username {$recipientUsername}.</p><p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p><p>Thank you for considering {$contextName} as a venue for your work.</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (33, 'REVIEW_DECLINE', 'en', 'Review Decline', 'Unable to Review', 'Editors:<br />
<br />
I am afraid that at this time I am unable to review the submission, &quot;{$submissionTitle},&quot; for {$contextName}. Thank you for thinking of me, and another time feel free to call on me.<br />
<br />
{$senderName}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (14, 'SUBMISSION_ACK', 'id', 'Konfirmasi Pengiriman', 'Terima kasih atas naskah yang anda kirimkan ke {$contextName}', '<p>Kepada Yth. {$recipientName},</p><p>Terimakasih atas pengiriman naskah anda ke {$contextName}. Kami telah menerima naskah anda, "{$submissionTitle}", dan anggota tim editorial kami akan segera mengeceknya. Email akan dikirimkan kepada anda ketika keputusan sudah dibuat, dan kami akan menghubungi anda jika ada informasi lebih lanjut.</p><p>Anda dapat melihat naskah anda dan mengecek progresnya melalui proses editorial pada lokasi berikut:</p><p>URL naskah: {$authorSubmissionUrl}</p><p>Jika anda sudah keluar dari sistem, anda dapat login kembali dengan username {$recipientUsername}.</p><p>Jika ada pertanyaan, silakan hubungi saya dari <a href="{$authorSubmissionUrl}">dasbor pengiriman</a>.</p><p>Terima kasih telah mempertimbangkan {$contextName} sebagai tempat untuk karya anda.</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (15, 'SUBMISSION_ACK_NOT_USER', 'en', 'Submission Confirmation (Other Authors)', 'Submission confirmation', '<p>Dear {$recipientName},</p><p>You have been named as a co-author on a submission to {$contextName}. The submitter, {$submitterName}, provided the following details:</p><p>"{$submissionTitle}"<br>{$authorsWithAffiliation}</p><p>If any of these details are incorrect, or you do not wish to be named on this submission, please contact me.</p><p>Thank you for considering {$contextName} as a venue for your work.</p><p>Kind regards,</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (16, 'SUBMISSION_ACK_NOT_USER', 'id', 'Konfirmasi Pengiriman Naskah (Penulis yang Lain)', 'Konfirmasi pengiriman naskah', '<p>Kepada Yth. {$recipientName},</p><p>Nama anda ditulis sebagai co-author pada naskah {$contextName}. Pengirim naskah, {$submitterName}, memberikan detail berikut:</p><p>"{$submissionTitle}"<br>{$authorsWithAffiliation}</p><p>Jika terdapat kekeliruan, atau anda tidak ingin nama anda tercantum dalam naskah, silakan hubungi saya.</p><p>Terima kasih atas pertimbangannya dalam memilih {$contextName} untuk menerbitkan karya anda.</p><p>Hormat kami,</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (17, 'EDITOR_ASSIGN', 'en', 'Editor Assigned', 'You have been assigned as an editor on a submission to {$contextName}', '<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the editorial process.</p><p><a href="{$submissionUrl}">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>If you find the submission to be relevant for {$contextName}, please forward the submission to the review stage by selecting "Send to Review" and then assign reviewers by clicking "Add Reviewer".</p><p>If the submission is not appropriate for this journal, please decline the submission.</p><p>Thank you in advance.</p><p>Kind regards,</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (18, 'EDITOR_ASSIGN', 'id', 'Editor Ditugaskan', 'Anda telah ditugaskan sebagai editor untuk naskah pada {$contextName}', '<p>Yth. {$recipientName},</p><p>Naskah berikut telah ditugaskan kepada Anda untuk diperiksa melalui proses editorial.</p><p><a href="{$submissionUrl}">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Jika telah sesuai dengan {$contextName}, lanjutkan naskah tersebut ke tahap dengan memilih "Kirim ke Taha Review" lalu tugaskan seorang mitra bestari dengan mengklik "Tambahkan Mitra Bestari".</p><p>Jika tidak sesuai dengan ketentuan jurnal, silakan naskah ditolak.</p><p>Terima kasih.</p><p>Salam hormat,</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (19, 'REVIEW_CANCEL', 'en', 'Reviewer Unassign', 'Request for Review Cancelled', '<p>Dear {$recipientName},</p><p>Recently, we asked you to review a submission to {$contextName}. We have decided to cancel the request for you to reivew the submission, {$submissionTitle}.</p><p>We apologize any inconvenience this may cause you and hope that we will be able to call on you to assist with this journal''s review process in the future.</p><p>If you have any questions, please contact me.</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (20, 'REVIEW_CANCEL', 'id', 'Reviewer Tidak ditugaskan', 'Permohonan Review Dibatalkan', '<p>Yth {$recipientName},</p><p>Kami memutuskan untuk membatalkan permohonan review kami kepada Anda untuk naskah {$submissionTitle} pada {$contextName}.</p><p> Kami mohon maaf sebesar-besarnya untuk ketidaknyamanan ini dan kami harap di masa mendatang Anda dapat membantu proses review di jurnal ini.</p><p>Jika ada pertanyaan, silakan hubungi kami.</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (21, 'REVIEW_REINSTATE', 'en', 'Reviewer Reinstate', 'Can you still review something for {$contextName}?', '<p>Dear {$recipientName},</p><p>We recently cancelled our request for you to review a submission, {$submissionTitle}, for {$contextName}. We''ve reversed that decision and we hope that you are still able to conduct the review.</p><p>If you are able to assist with this submission''s review, you can <a href="{$reviewAssignmentUrl}">login to the journal</a> to view the submission, upload review files, and submit your review request.</p><p>If you have any questions, please contact me.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (22, 'REVIEW_REINSTATE', 'id', 'Reviewer Mengembalikan Kembali', 'Bersediakah Anda mereview lagi pada {$contextName}?', '<p>Yang terhotmat {$recipientName}:</p><p>Kami membatalkan permintaan review kepada Anda untuk menelaah naskah, {$submissionTitle}, untuk {$contextName}. Kami mengubah keputusan dan kami berharap Anda tetap dapat membantu proses review jurnal kami.</p><p>Jika Anda bisa membantu review naskah ini, Anda bisa <a href="{$reviewAssignmentUrl}">login ke jurnal</a> untuk mereview naskah, unggah hasil review, dan mengirim permintaan review Anda.</p><p>Jika ada pertanyaan, silakan hubungi saya.</p><p>Salam Hormat,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (23, 'REVIEW_RESEND_REQUEST', 'en', 'Resend Review Request to Reviewer', 'Requesting your review again for {$contextName}', '<p>Dear {$recipientName},</p><p>Recently, you declined our request to review a submission, "{$submissionTitle}", for {$contextName}. I''m writing to see if you are able to conduct the review after all.</p><p>We would be grateful if you''re able to perform this review, but we understand if that is not possible at this time. Either way, please <a href="{$reviewAssignmentUrl}">accept or decline the request</a> by {$responseDueDate}, so that we can find an alternate reviewer.</p><p>If you have any questions, please contact me.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (24, 'REVIEW_RESEND_REQUEST', 'id', 'Mengirimkan kembali Permintaan untuk Mereview kepada Reviewer', 'Mohon anda untuk melakukan review kembali untuk {$contextName}', '<p>Kepada Yth. {$recipientName},</p><p>Baru-baru ini, anda menolak permintaan kami untuk mereview artikel, "{$submissionTitle}", untuk {$contextName}. Saya menghubungi untuk menanyakan kembali jika anda dapat melakukan review.</p><p>Kami sangat berterima kasih jika anda dapat melakukan review ini, tetapi kami mengerti jika anda tidak dapat melakukannya pada saat itu. Mohon untuk <a href="{$reviewAssignmentUrl}">menerima atau menolak permintaan</a> pada {$responseDueDate}, sehingga kami dapat menemukan reviewer yang lain.</p><p>Jika anda mempunyai pertanyaan, silakan hubungi saya.</p><p>Hormat kami,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (34, 'REVIEW_DECLINE', 'id', 'Menolak Review', 'Tidak Dapat Melakukan Review', 'Editor:<br />
<br />
Mohon maaf saat ini saya tidak dapat melakukan review terhadap naskah, &quot;{$submissionTitle},&quot; untuk {$contextName}. Terimakasih telah mempercayakann kepada saya, dan lain waktu silakan menghubungi saya lagi.<br />
<br />
{$senderName}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (25, 'REVIEW_REQUEST', 'en', 'Review Request', 'Invitation to review', '<p>Dear {$recipientName},</p><p>I believe that you would serve as an excellent reviewer for a submission  to {$contextName}. The submission''s title and abstract are below, and I hope that you will consider undertaking this important task for us.</p><p>If you are able to review this submission, your review is due by {$reviewDueDate}. You can view the submission, upload review files, and submit your review by logging into the journal site and following the steps at the link below.</p><p><a href="{$reviewAssignmentUrl}">{$submissionTitle}</a></p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please <a href="{$reviewAssignmentUrl}">accept or decline</a> the review by <b>{$responseDueDate}</b>.</p><p>You may contact me with any questions about the submission or the review process.</p><p>Thank you for considering this request. Your help is much appreciated.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (26, 'REVIEW_REQUEST', 'id', 'Permintaan Review', 'Undangan mereview', '<p>Yth. {$recipientName},</p><p>Kami memandang bahwa Anda merupakan reviewer yang tepat untuk naskah {$contextName}. Abstrak dan judul naskah tersebut disertakan di bawah ini, dan kami berharap Anda berkenan melakukannya.</p><p>Jika Anda berkenan mereview naskah ini, batas waktu yang ditentapkan adalah {$reviewDueDate}. Silakan login ke web jurnal untuk melihat, mengunggah file review, dan mengirimkan hasil telaah Anda dan ikuti langkah pada tautan berikut.</p><p><a href="{$reviewAssignmentUrl}">{$submissionTitle}</a></p><p><b>Abstrak</b></p>{$submissionAbstract}<p>Silakan merespon dengan memilih <a href="{$reviewAssignmentUrl}">menerima atau menolak</a> permintaan review sebelum <b>{$responseDueDate}</b></p><p>Silakan hubungi saya bila ada pertanyaan terkait naskah atau proses review.</p><p>Terima kasih telah mempertimbangkan permintaan kami. Bantuan Anda sangat berharga bagi Kami.</p><p>Salam hormat,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (27, 'REVIEW_REQUEST_SUBSEQUENT', 'en', 'Review Request Subsequent', 'Request to review a revised submission', '<p>Dear {$recipientName},</p><p>Thank you for your review of <a href="{$reviewAssignmentUrl}">{$submissionTitle}</a>. The authors have considered the reviewers'' feedback and have now submitted a revised version of their work. I''m writing to ask if you would conduct a second round of peer review for this submission.</p><p>If you are able to review this submission, your review is due by {$reviewDueDate}. You can <a href="{$reviewAssignmentUrl}">follow the review steps</a> to view the submission, upload review files, and submit your review comments.<p><p><a href="{$reviewAssignmentUrl}">{$submissionTitle}</a></p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please <a href="{$reviewAssignmentUrl}">accept or decline</a> the review by <b>{$responseDueDate}</b>.</p><p>Please feel free to contact me with any questions about the submission or the review process.</p><p>Thank you for considering this request. Your help is much appreciated.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (28, 'REVIEW_REQUEST_SUBSEQUENT', 'id', 'Permintaan Review Berikutnya', 'Permintaan untuk mereview naskah hasil revisi', '<p>Yang terhormat {$recipientName},</p><p>Terima kasih telah mereview <a href="{$reviewAssignmentUrl}">{$submissionTitle}</a>. Penulis telah mempertimbangkan saran mitra bestari dan saat ini telah mengirimkan versi revisi naskahnya. Kami menghubungi untuk menanyakan apakah Anda bersedia mereview pada putaran kedua untuk naskah ini.</p><p>Jika bersedia, batas waktu review berakhir sebelum {$reviewDueDate}. Anda dapat <a href="{$reviewAssignmentUrl}">mengikuti tahapan review</a> untuk melihat naskah, mengunggah file review, dan mengirimkan komentar Anda.<p><p><a href="{$reviewAssignmentUrl }"{$submissionTitle}</a></p><p>Abstrak</p>{$submissionAbstract}<p>Harap terima atau tolak permintaan review sebelum {$responseDueDate}.</p><p>Jangan sungkan menghubungi saya jika ada pertanyaan terkait naskah atau proses review.</p><p>Terima kasih telah mempertimbangkan permintaan kami. Bantuan Anda sangat berharga bagi kami.</p><p>Hormat kami,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (29, 'REVIEW_RESPONSE_OVERDUE_AUTO', 'en', 'Review Response Overdue (Automated)', 'Will you be able to review this for us?', '<p>Dear {$recipientName},</p><p>This email is an automated reminder from {$contextName} in regards to our request for your review of the submission, "{$submissionTitle}."</p><p>You are receiving this email because we have not yet received a confirmation from you indicating whether or not you are able to undertake the review of this submission.</p><p>Please let us know whether or not you are able to undertake this review by using our submission management software to accept or decline this request.</p><p>If you are able to review this submission, your review is due by {$reviewDueDate}. You can follow the review steps to view the submission, upload review files, and submit your review comments.</p><p><a href="{$reviewAssignmentUrl}">{$submissionTitle}</a></p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please feel free to contact me with any questions about the submission or the review process.</p><p>Thank you for considering this request. Your help is much appreciated.</p><p>Kind regards,</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (30, 'REVIEW_RESPONSE_OVERDUE_AUTO', 'id', 'Respon Review Telah Melewati Batas Waktu (Otomatis)', 'Apakah Anda bersedia mereview naskah ini?', '<p>Yang terhormat {$recipientName},</p><p>Email ini merupakan pengingat otomatis dari {$contextName} sehubungan dengan permintaan kami untuk meninjau kiriman, "{$submissionTitle}."</p><p>Anda menerima email ini karena kami belum menerima konfirmasi dari Anda yang menunjukkan apakah Anda dapat melakukan peninjauan kiriman ini atau tidak.</p><p>Harap beri tahu kami apakah Anda dapat melakukan peninjauan ini atau tidak dengan menggunakan perangkat lunak manajemen kiriman kami untuk menerima atau menolak permintaan ini.</p><p>Jika Anda dapat meninjau kiriman ini, peninjauan Anda harus dilakukan paling lambat {$reviewDueDate}. Anda dapat mengikuti langkah-langkah peninjauan untuk melihat kiriman, mengunggah berkas peninjauan, dan mengirimkan komentar peninjauan Anda.</p><p><a href="{$reviewAssignmentUrl}">{$submissionTitle}</a></p><p><b>Abstract</b></p>{$submissionAbstract}<p>Silakan hubungi saya jika ada pertanyaan tentang kiriman atau proses peninjauan.</p><p>Terima kasih telah mempertimbangkan permintaan ini. Bantuan Anda sangat kami hargai.</p><p>Salam hormat,</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (31, 'REVIEW_CONFIRM', 'en', 'Review Confirm', 'Review accepted: {$reviewerName} accepted review assignment for #{$submissionId} {$authorsShort} — "{$submissionTitle}"', '<p>Dear {$recipientName},</p><p>{$reviewerName} has accepted the following review:</p><p><a href="{$submissionUrl}">#{$submissionId} {$authorsShort} — "{$submissionTitle}"</a><br /><b>Type:</b> {$reviewMethod}</p><p><b>Review Due:</b> {$reviewDueDate}</p><p>Login to <a href="{$submissionUrl}">view all reviewer assignments</a> for this submission.</p><br><br>—<br>This is an automated message from <a href="{$contextUrl}">{$contextName}</a>.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (32, 'REVIEW_CONFIRM', 'id', 'Mengkonfirmasi Review', 'Review diterima: {$reviewerName} menerima penugasan review untuk #{$submissionId} {$authorsShort} — "{$submissionTitle}"', '<p>Kepada Yth. {$recipientName},</p><p>{$reviewerName} telah menerima review berikut:</p><p><a href="{$submissionUrl}">#{$submissionId} {$authorsShort} — "{$submissionTitle}"</a><br /><b>Tipe:</b> {$reviewMethod}</p><p><b>Batas akhir Review:</b> {$reviewDueDate}</p><p>Login ke<a href="{$submissionUrl}">lihat seluruh tugas reviewer</a> untuk naskah berikut.</p><br><br>—<br>Ini adalah pesan otomatis dari <a href="{$contextUrl}">{$contextName}</a>.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (35, 'REVIEW_ACK', 'en', 'Review Acknowledgement', 'Thank you for your review', '<p>Dear {$recipientName},</p>
<p>Thank you for completing your review of the submission, "{$submissionTitle}", for {$contextName}. We appreciate your time and expertise in contributing to the quality of the work that we publish.</p>
<p>It has been a pleasure to work with you as a reviewer for {$contextName}, and we hope to have the opportunity to work with you again in the future.</p>
<p>Kind regards,</p>
<p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (36, 'REVIEW_ACK', 'id', 'Apresiasi Terhadap Review', 'Terima kasih atas review anda', '<p>Kepada Yth. {$recipientName},</p>
<p>Terimakasih telah menyelesaikan review dari naskah, "{$submissionTitle}", pada {$contextName}. Kami sangat menghargai kontribusi anda terhadap kualitas karya yang kami terbitkan.</p>
<p>Kami sangat senang bisa bekerja sama dengan anda sebagai reviewer untuk {$contextName}, dan kami berharap dapat memiliki kesempatan untuk bekerja sama lagi dengan anda di masa yang akan datang.</p>
<p>Hormat kami,</p>
<p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (37, 'REVIEW_REMIND', 'en', 'Review Reminder', 'A reminder to please complete your review', '<p>Dear {$recipientName},</p><p>Just a gentle reminder of our request for your review of the submission, "{$submissionTitle}," for {$contextName}. We were expecting to have this review by {$reviewDueDate} and we would be pleased to receive it as soon as you are able to prepare it.</p><p>You can <a href="{$reviewAssignmentUrl}">login to the journal</a> and follow the review steps to view the submission, upload review files, and submit your review comments.</p><p>If you need an extension of the deadline, please contact me. I look forward to hearing from you.</p><p>Thank you in advance and kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (38, 'REVIEW_REMIND', 'id', 'Pengingat Review', 'Pengingat untuk menyelesaikan tugas review Anda', '<p> Yth {$recipientName},</p><p>Sekedar mengingatkan tentang permohonan kami untuk melakukan review terhadap naskah, "{$submissionTitle}," untuk {$contextName}. Kami mengharapkan telah menerima review ini pada {$reviewDueDate}, dan akan sangat berbahagia bila Anda dapat menyelesaikannya.</p><p>Silakan <a href="{$reviewAssignmentUrl}">login ke jurnal</a> dan ikuti petunjuk review untuk melihat naskah, mengunggah file review, serta mengirim komentar review.</p><p>Jika butuh tambahan waktu, silakan hubungi saya. Kami menunggu tanggapan Anda.</p><p>Terima kasih atas perhatian Anda dan salam hormat,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (39, 'REVIEW_REMIND_AUTO', 'en', 'Review Reminder (Automated)', 'A reminder to please complete your review', '<p>Dear {$recipientName}:</p><p>This email is an automated reminder from {$contextName} in regards to our request for your review of the submission, "{$submissionTitle}."</p><p>We were expecting to have this review by {$reviewDueDate} and we would be pleased to receive it as soon as you are able to prepare it.</p><p>Please <a href="{$reviewAssignmentUrl}">login to the journal</a> and follow the review steps to view the submission, upload review files, and submit your review comments.</p><p>If you need an extension of the deadline, please contact me. I look forward to hearing from you.</p><p>Thank you in advance and kind regards,</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (40, 'REVIEW_REMIND_AUTO', 'id', 'Pengingat Review (Otomatis)', 'Pengingat untuk menyelesaikan review Anda', '<p>Yth {$recipientName}:</p><p>Sekedar mengingatkan tentang permohonan kami untuk melakukan review terhadap naskah, "{$submissionTitle}" untuk {$contextName}. </p><p>Kami mengharapkan telah menerima review ini pada {$reviewDueDate} dan kami berterima kasih bila dapat menyelesaikannya lebih awal.</p><p>Silakan <a href="{$reviewAssignmentUrl}">login ke jurnal</a> dan ikuti tahapan untuk melihat naskah, mengunggah file review, dan mwnambahkana komentar review.</p><p>Jika Anda membutuhkan tambahan waktu, silakan hubungi saya. Kami menunggu kabar dari Anda.</p><p>Terima kasih dan salam hormat,</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (41, 'REVIEW_COMPLETE', 'en', 'Review Completed', 'Review complete: {$reviewerName} recommends {$reviewRecommendation} for #{$submissionId} {$authorsShort} — "{$submissionTitle}"', '<p>Dear {$recipientName},</p><p>{$reviewerName} completed the following review:</p><p><a href="{$submissionUrl}">#{$submissionId} {$authorsShort} — "{$submissionTitle}"</a><br /><b>Recommendation:</b> {$reviewRecommendation}<br /><b>Type:</b> {$reviewMethod}</p><p>Login to <a href="{$submissionUrl}">view all files and comments</a> provided by this reviewer.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (42, 'REVIEW_COMPLETE', 'id', 'Review Telah Lengkap', 'Review lengkap: {$reviewerName} merekomentasikan {$reviewRecommendation} untuk #{$submissionId} {$authorsShort} — "{$submissionTitle}"', '<p>Kepada Yth. {$recipientName},</p><p>{$reviewerName} telah menyelesaikan review berikut:</p><p><a href="{$submissionUrl}">#{$submissionId} {$authorsShort} — "{$submissionTitle}"</a><br /><b>Rekomendasi:</b> {$reviewRecommendation}<br /><b>Tipe:</b> {$reviewMethod}</p><p>Masuk ke <a href="{$submissionUrl}">lihat seluruh file dan komentar</a> yang diberikan oleh reviewer ini.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (43, 'REVIEW_EDIT', 'en', 'Review Edited', 'Your review assignment has been changed for {$contextName}', '<p>Dear {$recipientName},</p><p>An editor has made changes to your review assignment for {$contextName}. Please review the details below and let us know if you have any questions.</p><p><a href="{$reviewAssignmentUrl}">"{$submissionTitle}"</a><br /><b>Type:</b> {$reviewMethod}<br /><b>Accept or Decline By:</b> {$responseDueDate}<br /><b>Submit Review By:</b> {$reviewDueDate}</p><p>You can login to <a href="{$reviewAssignmentUrl}">complete this review</a> at any time.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (44, 'REVIEW_EDIT', 'id', 'Review Diedit', 'Penugasan review anda sudah diubah untuk {$contextName}', '<p>Kepada Yth. {$recipientName},</p><p>Editor telah membuat perubahan pada penugasan review anda untuk {$contextName}. Mohon review detail di bawah ini dan beritahukan kepada kami jika anda ada pertanyaan.</p><p><a href="{$reviewAssignmentUrl}">"{$submissionTitle}"</a><br /><b>Tipe:</b> {$reviewMethod}<br /><b>Diterima atau Ditolak Pada:</b> {$responseDueDate}<br /><b>Kirim Review Pada:</b> {$reviewDueDate}</p><p>Anda dapat login ke <a href="{$reviewAssignmentUrl}">lengkapi review ini</a> kapan saja.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (45, 'EDITOR_DECISION_ACCEPT', 'en', 'Submission Accepted', 'Your submission has been accepted to {$contextName}', '<p>Dear {$recipientName},</p><p>I am pleased to inform you that we have decided to accept your submission without further revision. After careful review, we found your submission, {$submissionTitle}, to meet or exceed our expectations. We are excited to publish your piece in {$contextName} and we thank you for choosing our journal as a venue for your work.</p><p>Your submission is now forthcoming in a future issue of {$contextName} and you are welcome to include it in your list of publications. We recognize the hard work that goes into every successful submission and we want to congratulate you on reaching this stage.</p><p>Your submission will now undergo copy editing and formatting to prepare it for publication.</p><p>You will shortly receive further instructions.</p><p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (81, 'OPEN_ACCESS_NOTIFY', 'en', 'Open Access Notify', 'Free to read: {$issueIdentification} of {$contextName} is now open access', '<p>Dear {$recipientName},</p><p>We are pleased to inform you that <a href="{$issueUrl}">{$issueIdentification}</a> of {$contextName} is now available under open access.  A subscription is no longer required to read this issue.</p><p>Thank you for your continuing interest in our work.</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (46, 'EDITOR_DECISION_ACCEPT', 'id', 'Naskah Diterima', 'Naskah Anda telah diterima pada {$contextName}', '<p>Yang terhormat {$recipientName},</p><p>Dengan senang hati saya informasikan bahwa kami telah memutuskan untuk menerima naskha Anda tanpa revisi lebih lanjut. Setelah review matang, kami memutuskan bahwa naskah Anda, {$submissionTitle}, memenuhi atau melebihi harapan kami. Kami sangat senang untuk menerbitkan artikel Anda di {$contextName} dan kami berterima kasih telah memilih jurnal kami sebagai tempat untuk karya Anda.</p><p>Naskah Anda sedang masuk edisi forthcoming dalam edisi {$contextName} dan Anda dipersilakan untuk memasukkannya ke dalam daftar publikasi Anda. Kami menghargai kerja keras untuk setiap karya dan mengucapkan selamat kepada Anda karena telah mencapai tahap ini.</p><p>Artikel Anda sedang dalam tahap pengeditan dan pemformatan salinan agas siap diterbitkan.</p><p >Anda akan segera menerima petunjuk lebih lanjut.</p><p>Jika memiliki pertanyaan, silakan hubungi saya melalui <a href="{$authorSubmissionUrl}">dashbord naskah</a> Anda.</p><p >Hormat kami,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (47, 'EDITOR_DECISION_SEND_TO_EXTERNAL', 'en', 'Sent to Review', 'Your submission has been sent for review', '<p>Dear {$recipientName},</p><p>I am pleased to inform you that an editor has reviewed your submission, "{$submissionTitle}", and has decided to send it for peer review. An editor will identify qualified reviewers who will provide feedback on your submission.</p><p>{$reviewTypeDescription} You will hear from us with feedback from the reviewers and information about the next steps.</p><p>Please note that sending the submission to peer review does not guarantee that it will be published. We will consider the reviewers'' recommendations before deciding to accept the submission for publication. You may be asked to make revisions and respond to the reviewers'' comments before a final decision is made.</p><p>If you have any questions, please contact me from your submission dashboard.</p><p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (48, 'EDITOR_DECISION_SEND_TO_EXTERNAL', 'id', 'Dikirimkan ke Review', 'Naskah anda telah dikirim untuk direview', '<p>Kepada Yth. {$recipientName},</p><p>Dengan senang hati, saya informasikan bahwa editor telah mereview naskah anda, "{$submissionTitle}", dan memutuskan untuk mengirimkan untuk proses review. Editor akan memilih reviewer yang berkualitas yang akan memberikan masukan pada naskah anda.</p><p>{$reviewTypeDescription} Anda akan mendapatkan masukan dari reviewer dan informasi mengenai langkah selanjutnya.</p><p>Harap diperhatikan bahwa pengiriman naskah ke proses review tidak menjamin bahwa naskah akan diterbitkan. Kami akan mempertimbangkan rekomendasi dari para reviewer sebelum memutuskan untuk menerima naskah untuk dipublikasikan. Anda mungkin akan diminta melakukan revisi dan memberikan respon pada komentar reviewer sebelum keputusan akhir dibuat.</p><p>Jika ada pertanyaan, silakan kontak saya melalui dasbor pengiriman.</p><p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (49, 'EDITOR_DECISION_SEND_TO_PRODUCTION', 'en', 'Sent to Production', 'Next steps for publishing your submission', '<p>Dear {$recipientName},</p><p>I am writing from {$contextName} to let you know that the editing of your submission, "{$submissionTitle}", is complete. Your submission will now advance to the production stage, where the final galleys will be prepared for publication. We will contact you if we need any further assistance.</p><p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (50, 'EDITOR_DECISION_SEND_TO_PRODUCTION', 'id', 'Dikirimkan ke Produksi', 'Tahap selanjutnya untuk menerbitkan naskah Anda', '<p>Kepada Yth. {$recipientName},</p><p>Saya menghubungi dari {$contextName} untuk memberitahukan kepada anda bahwa proses edit naskah anda, "{$submissionTitle}", telah selesai. Naskah anda akan masuk ke tahap produksi, dimana galley akhir akan disiapkan untuk penerbitan. Kami akan menghubungi anda jika kami membutuhkan bantuan lebih lanjut.</p><p>Jika anda ada pertanyaan, silakan kontak saya dari <a href="{$authorSubmissionUrl}">dasbor pengiriman anda</a>.</p><p>Hormat kami,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (51, 'EDITOR_DECISION_REVISIONS', 'en', 'Revisions Requested', 'Your submission has been reviewed and we encourage you to submit revisions', '<p>Dear {$recipientName},</p><p>Your submission "{$submissionTitle}" has been reviewed and we would like to encourage you to submit revisions that address the reviewers'' comments. An editor will review these revisions and if they address the concerns adequately, your submission may be accepted for publication.</p><p>The reviewers'' comments are included at the bottom of this email. Please respond to each point in the reviewers'' comments and identify what changes you have made. If you find any of the reviewer''s comments to be unjustified or inappropriate, please explain your perspective.</p><p>When you have completed your revisions, you can upload revised documents along with your response to the reviewers'' comments at your <a href="{$authorSubmissionUrl}">submission dashboard</a>. If you have been logged out, you can login again with the username {$recipientUsername}.</p><p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p><p>We look forward to receiving your revised submission.</p><p>Kind regards,</p>{$signature}<hr><p>The following comments were received from reviewers.</p>{$allReviewerComments}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (52, 'EDITOR_DECISION_REVISIONS', 'id', 'Revisi Diminta', 'Naskah anda telah direview dan kami sarankan untuk segera mengirimkan revisinya', '<p>Kepada Yth. {$recipientName},</p><p>Naskah anda "{$submissionTitle}" telah direview dan kami menyarankan anda untuk mengirimkan revisi berdasarkan komentar dari para reviewer. Editor akan mereview revisi ini dan jika mereka mengatasi permasalahan tersebut secara memadai, naskah anda dapat diterima untuk diterbitkan.</p><p>Komentar para reviewer ada pada bagian bawah email ini. Harap menanggapi tiap poin pada komentar para reviewer dan identifikasi perubahan apa yang telah anda buat. Jika anda merasa komentar para reviewer tidak dapat dibenarkan atau tidak pantas, mohon jelaskan pandangan anda.</p><p>Setelah anda melengkapi revisinya, anda dapat menggunggah revisi dokumen beserta dengan tanggapan pada komentar para reviewer di <a href="{$authorSubmissionUrl}">dasbor pengiriman anda</a>. Jika anda sudah keluar dari sistem, anda dapat masuk kembali dengan menggunakan username {$recipientUsername}.</p><p>Jika ada pertanyaan, silakan menghubungi saya melalui <a href="{$authorSubmissionUrl}">dasbor pengiriman anda</a>.</p><p>Kami menunggu revisi naskah anda.</p><p>Kind regards,</p>{$signature}<hr><p>Komentar berikut diterima dari para reviewer.</p>{$allReviewerComments}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (82, 'OPEN_ACCESS_NOTIFY', 'id', 'Notifikasi Akses Terbuka', 'Gratis dibaca: {$issueIdentification} of {$contextName} sudah akses terbuka sekarang', '<p>Yth {$recipientName},</p><p>Dengan senang hati kami informasikan bahwa <a href="{$issueUrl}">{$issueIdentification}</a> dari {$contextName} telah menjadikan terbitan Open Access. Langganan tidak diperlukan lagi untuk membaca terbitan ini.</p><p>Terima kasih atas perhatiannya.</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (83, 'SUBSCRIPTION_BEFORE_EXPIRY', 'en', 'Subscription Expires Soon', 'Notice of Subscription Expiry', '{$recipientName}:<br />
<br />
Your {$contextName} subscription is about to expire.<br />
<br />
{$subscriptionType}<br />
Expiry date: {$expiryDate}<br />
<br />
To ensure the continuity of your access to this journal, please go to the journal website and renew your subscription. You are able to log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />
<br />
If you have any questions, please feel free to contact me.<br />
<br />
{$subscriptionSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (53, 'EDITOR_DECISION_RESUBMIT', 'en', 'Resubmit for Review', 'Your submission has been reviewed - please revise and resubmit', '<p>Dear {$recipientName},</p><p>After reviewing your submission, "{$submissionTitle}", the reviewers have recommended that your submission cannot be accepted for publication in its current form. However, we would like to encourage you to submit a revised version that addresses the reviewers'' comments. Your revisions will be reviewed by an editor and may be sent out for another round of peer review.</p><p>Please note that resubmitting your work does not guarantee that it will be accepted.</p><p>The reviewers'' comments are included at the bottom of this email. Please respond to each point and identify what changes you have made. If you find any of the reviewer''s comments inappropriate, please explain your perspective. If you have questions about the recommendations in your review, please include these in your response.</p><p>When you have completed your revisions, you can upload revised documents along with your response to the reviewers'' comments <a href="{$authorSubmissionUrl}">at your submission dashboard</a>. If you have been logged out, you can login again with the username {$recipientUsername}.</p><p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p><p>We look forward to receiving your revised submission.</p><p>Kind regards,</p>{$signature}<hr><p>The following comments were received from reviewers.</p>{$allReviewerComments}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (54, 'EDITOR_DECISION_RESUBMIT', 'id', 'Dikirimkan Kembali untuk Review', 'Naskah anda telah direview - silakan revisi dan kirim ulang', '<p>Kepada Yth. {$recipientName},</p><p>Setelah mereview naskah anda, "{$submissionTitle}", para reviewer merekomendasikan bahwa naskah anda tidak dapat diterbitkan saat ini. Namun, kami menyarankan anda untuk mengirimkan versi revisi yang membahas komentar dari para reviewer. Revisi anda akan direview oleh editor dan dapat dikirimkan untuk putaran review yang baru.</p><p>Harap diperhatikan bahwa mengirimkan ulang naskah anda tidak menjamin bahwa akan diterima.</p><p>Komentar dari para reviewer terdapat pada bagian bawah email ini. Mohon tanggapi setiap poin dan identifikasi perubahan apa yang telah anda buat. Jika anda merasa bahwa komentar para reviewer tidak pantas, mohon jelaskan pandangan anda. Jika anda mempunyai pertanyaan mengenai rekomendasi pada hasil review anda, mohon masukkan ini pada tanggapan anda.</p><p>Jika anda telah menyelesaikan revisinya, anda dapat mengunggah revisi naskah dengan tanggapan terhadap komentar reviewer <a href="{$authorSubmissionUrl}">pada dasbor pengiriman anda</a>. Jika anda sudah keluar, anda dapat masuk kembali dengan username {$recipientUsername}.</p><p>Jika ada pertanyaan, silakan kontak saya melalui <a href="{$authorSubmissionUrl}">dasbor pengiriman anda</a>.</p><p>Kami menunggu untuk menerima revisi naskah anda.</p><p>Hormat kami,</p>{$signature}<hr><p>Komentar berikut kami terima dari para reviewer.</p>{$allReviewerComments}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (55, 'EDITOR_DECISION_DECLINE', 'en', 'Submission Declined', 'Your submission has been declined', '<p>Dear {$recipientName},</p><p>While we appreciate receiving your submission, we are unable to accept "{$submissionTitle}" for publication on the basis of the comments from reviewers.</p><p>The reviewers'' comments are included at the bottom of this email.</p><p>Thank you for submitting to {$contextName}. Although it is disappointing to have a submission declined, I hope you find the reviewers'' comments to be constructive and helpful.</p><p>You are now free to submit the work elsewhere if you choose to do so.</p><p>Kind regards,</p>{$signature}<hr><p>The following comments were received from reviewers.</p>{$allReviewerComments}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (56, 'EDITOR_DECISION_DECLINE', 'id', 'Naskah Dibatalkan', 'Naskah Anda telah ditolak', '<p>Kepada Yth. {$recipientName},</p><p>Kami dengan menghargai naskah anda, tetapi kami tidak dapat menerima "{$submissionTitle}" untuk penerbitan berdasarkan komentar dari para reviewer.</p><p>Komentar reviewer terdapat pada bagian bawah dari email ini.</p><p>Terima kasih sudah mengirimkan naskah ke {$contextName}. Meskipun naskah anda ditolak, saya harap komentar dari para reviewer membangun dan berguna.</p><p>Anda bebas untuk mengirimkan naskah ke mana saja yang anda inginkan.</p><p>Hormat kami,</p>{$signature}<hr><p>Komentar berikut kami terima dari para reviewer.</p>{$allReviewerComments}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (57, 'EDITOR_DECISION_INITIAL_DECLINE', 'en', 'Submission Declined (Pre-Review)', 'Your submission has been declined', '<p>Dear {$recipientName},</p><p>I’m sorry to inform you that, after reviewing your submission, "{$submissionTitle}", the editor has found that it does not meet our requirements for publication in {$contextName}.</p><p>I wish you success if you consider submitting your work elsewhere.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (58, 'EDITOR_DECISION_INITIAL_DECLINE', 'id', 'Naskah Ditolak (Pre-Review)', 'Naskah anda telah ditolak', '<p>Kepada Yth. {$recipientName},</p><p>Dengan sangat menyesal, kami informasikan bahwa, setelah mereview naskah anda, "{$submissionTitle}", editor menyatakan bahwa naskah tersebut tidak memenuhi kriteria penerbitan pada {$contextName}.</p><p>Semoga anda sukses untuk mengirimkan karya anda ke tempat yang lain.</p><p>Hormat kami,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (59, 'EDITOR_RECOMMENDATION', 'en', 'Recommendation Made', 'Editor Recommendation', '<p>Dear {$recipientName},</p><p>After considering the reviewers'' feedback, I would like to make the following recommendation regarding the submission "{$submissionTitle}".</p><p>My recommendation is: {$recommendation}.</p><p>Please visit the submission''s <a href="{$submissionUrl}">editorial workflow</a> to act on this recommendation.</p><p>Please feel free to contact me with any questions.</p><p>Kind regards,</p><p>{$senderName}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (60, 'EDITOR_RECOMMENDATION', 'id', 'Rekomendasi Telah Dibuat', 'Rekomendasi Editor', '<p>Kepada Yth. {$recipientName},</p><p>Setelah mempertimbangkan saran dari para reviewer, saya akan memberikan rekomendasi terkait dengan naskah "{$submissionTitle}".</p><p>Rekomendasi saya adalah: {$recommendation}.</p><p>Silakan kunjungi <a href="{$submissionUrl}">alur kerja editorial naskah</a> untuk menindaklanjuti rekomendasi ini.</p><p>Jangan sungkan untuk menghubungi saya jika ada pertanyaan.</p><p>Hormat kami,</p><p>{$senderName}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (61, 'EDITOR_DECISION_NOTIFY_OTHER_AUTHORS', 'en', 'Notify Other Authors', 'An update regarding your submission', '<p>The following email was sent to {$submittingAuthorName} from {$contextName} regarding "{$submissionTitle}".</p>
<p>You are receiving a copy of this notification because you are identified as an author of the submission. Any instructions in the message below are intended for the submitting author, {$submittingAuthorName}, and no action is required of you at this time.</p>

{$messageToSubmittingAuthor}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (62, 'EDITOR_DECISION_NOTIFY_OTHER_AUTHORS', 'id', 'Memberitahukan Penulis Lain', 'Informasi terbaru mengenai naskah anda', '<p>Email berikut ini dikirim ke {$submittingAuthorName} dari {$contextName} mengenai "{$submissionTitle}".</p>
<p>Anda menerima notifikasi ini karena anda teridentifikasi sebagai penulis dari naskah. Instruksi dari pesan di bawah ini dimaksudkan untuk penulis artikel, {$submittingAuthorName}, dan tidak ada yang harus dilakukan pada tahap ini.</p>

{$messageToSubmittingAuthor}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (63, 'EDITOR_DECISION_NOTIFY_REVIEWERS', 'en', 'Notify Reviewers of Decision', 'Thank you for your review', '<p>Dear {$recipientName},</p>
<p>Thank you for completing your review of the submission, "{$submissionTitle}", for {$contextName}. We appreciate your time and expertise in contributing to the quality of the work that we publish. We have shared your comments with the authors, along with our other reviewers'' comments and the editor''s decision.</p>
<p>Based on the feedback we received, we have notified the authors of the following:</p>
<p>{$decisionDescription}</p>
<p>Your recommendation was considered alongside the recommendations of other reviewers before coming to a decision. Occasionally the editor''s decision may differ from the recommendation made by one or more reviewers. The editor considers many factors, and does not take these decisions lightly. We are grateful for our reviewers'' expertise and suggestions.</p>
<p>It has been a pleasure to work with you as a reviewer for {$contextName}, and we hope to have the opportunity to work with you again in the future.</p>
<p>Kind regards,</p>
<p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (64, 'EDITOR_DECISION_NOTIFY_REVIEWERS', 'id', 'Memberitahukan Reviewer mengenai Keputusan Naskah', 'Terima kasih atas review anda', '<p>Kepada Yth {$recipientName},</p>
<p>Terima kasih karena sudah mengirimkan review dari naskah, "{$submissionTitle}", untuk {$contextName}. Kami menghargai waktu dan keahlian anda dalam berkontribusi terhadap kualitas karya yang kami terbitkan. Kami sudah mengirimkan komentar anda kepada penulis, bersama dengan komentar dari reviewer-reviewer yang lain dan keputusan editor.</p>
<p>Berdasarkan umpan balik yang kami terima, kami telah memberitahukan penulis sebagai berikut:</p>
<p>{$decisionDescription}</p>
<p>Rekomendasi anda dipertimbangkan bersamaan dengan reviewer lain sebelum diambil keputusan. Kadang keputusan editor mungkin berbeda dari rekomendasi yang dibuat oleh satu reviewer atau lebih. Editor mempertimbangkan banyak faktor, dan tidak mengambil keputusan dengan mudah. Kami bersyukur atas keahlian dan saran dari para reviewer. </p>
<p>Kami sangat senang dapat bekerja sama dengan anda sebagai reviewer pada {$contextName}, dan kami berharap dapat memiliki kesempatan untuk bekerja sama kembali dengan anda di masa yang akan datang..</p>
<p>Hormat kami,</p>
<p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (65, 'EDITOR_DECISION_NEW_ROUND', 'en', 'New Review Round Initiated', 'Your submission has been sent for another round of review', '<p>Dear {$recipientName},</p>
<p>Your revised submission, "{$submissionTitle}", has been sent for a new round of peer review. 
You will hear from us with feedback from the reviewers and information about the next steps.</p>
<p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p>
<p>Kind regards,</p>
<p>{$signature}</p>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (66, 'EDITOR_DECISION_NEW_ROUND', 'id', 'Putaran Review yang Baru Diadakan', 'Artikel anda telah dikirimkan untuk putaran review yang berikutnya', '<p>Kepada Yth. {$recipientName},</p>
<p>Revisi artikel anda, "{$submissionTitle}", telah dikirim untuk putraran review yang baru. 
Anda akan mendengar umpan balik kami dari reviewer dan informasi mengenai langkah selanjutnya.</p>
<p>Jika anda mempunyai pertanyaan, silakan kontak saya dari <a href="{$authorSubmissionUrl}">dasbor pengiriman anda</a>.</p>
<p>Hormat kami,</p>
<p>{$signature}</p>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (67, 'EDITOR_DECISION_REVERT_DECLINE', 'en', 'Reinstate Declined Submission', 'We have reversed the decision to decline your submission', '<p>Dear {$recipientName},</p>
<p>The decision to decline your submission, "{$submissionTitle}", has been reversed. 
An editor will complete the round of review and you will be notified when a 
decision is made.</p>
<p>Occasionally, a decision to decline a submission will be recorded accidentally in 
our system and must be reverted. I apologize for any confusion this may have caused.</p>
<p>We will contact you if we need any further assistance.</p>
<p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p>
<p>Kind regards,</p>
<p>{$signature}</p>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (68, 'EDITOR_DECISION_REVERT_DECLINE', 'id', 'Peninjauan Kembali Naskah yang Ditolak', 'Kami telah membatalkan keputusan untuk menolak pengiriman artikel anda', '<p>Kepada Yth. {$recipientName},</p>
<p>Keputusan untuk menolak pengiriman artikel anda, "{$submissionTitle}", telah dibatalkan. 
Seorang editor akan melengkapi putaran review dan anda akan diberitahukan setelah 
keputusan dibuat.</p>
<p>Kadang, keputusan untuk menolak pengiriman artikel akan dicatat secara tidak sengaja pada
sistem kami dan harus dibatalkan. Saya mohon maaf atas kekeliruan yang terjadi.</p>
<p>Kami akan menghubungi anda jika kami membutuhkan bantuan lebih lanjut.</p>
<p>Jika anda mempunyai pertanyaan, silakan kontak saya dari <a href="{$authorSubmissionUrl}">dasbor pengiriman anda</a>.</p>
<p>Hormat kami,</p>
<p>{$signature}</p>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (69, 'EDITOR_DECISION_REVERT_INITIAL_DECLINE', 'en', 'Reinstate Submission Declined Without Review', 'We have reversed the decision to decline your submission', '<p>Dear {$recipientName},</p>
<p>The decision to decline your submission, "{$submissionTitle}", has been reversed. 
An editor will look further at your submission before deciding whether to decline 
the submission or send it for review.</p>
<p>Occasionally, a decision to decline a submission will be recorded accidentally in 
our system and must be reverted. I apologize for any confusion this may have caused.</p>
<p>We will contact you if we need any further assistance.</p>
<p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p>
<p>Kind regards,</p>
<p>{$signature}</p>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (70, 'EDITOR_DECISION_REVERT_INITIAL_DECLINE', 'id', 'Peninjauan Kembali Naskah yang Ditolak Tanpa Review', 'Kami telah membatalkan keputusan untuk menolak pengiriman artikel anda', '<p>Kepada Yth. {$recipientName},</p>
<p>Keputusan untuk membatalkan pengiriman artikel anda, "{$submissionTitle}", telah dibatalkan. 
Seorang editor akan melihat artikel anda lebih lanjut sebelum memutuskan apakah menolak 
artikel atau mengirimkannya untuk direview.</p>
<p>Kadang, keputusan untuk menolak artikel, akan dicatat tanpa sengaja pada 
sistem kami dan harus dibatalkan. Saya minta maaf atas kekeliruan yang terjadi.</p>
<p>Kami akan menghubungi anda jika kami membutuhkan bantuan.</p>
<p>Jika anda mempunyai pertanyaan, silakan kontak saya dari <a href="{$authorSubmissionUrl}">dasbor pengiriman anda</a>.</p>
<p>Hormat kami,</p>
<p>{$signature}</p>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (71, 'EDITOR_DECISION_SKIP_REVIEW', 'en', 'Submission Accepted (Without Review)', 'Your submission has been sent for copyediting', '<p>Dear {$recipientName},</p>
<p>I am pleased to inform you that we have decided to accept your submission without peer review. We found your submission, {$submissionTitle}, to meet our expectations, and we do not require that work of this type undergo peer review. We are excited to publish your piece in {$contextName} and we thank you for choosing our journal as a venue for your work.</p>
Your submission is now forthcoming in a future issue of {$contextName} and you are welcome to include it in your list of publications. We recognize the hard work that goes into every successful submission and we want to congratulate you on your efforts.</p>
<p>Your submission will now undergo copy editing and formatting to prepare it for publication. </p>
<p>You will shortly receive further instructions.</p>
<p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p>
<p>Kind regards,</p>
<p>{$signature}</p>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (72, 'EDITOR_DECISION_SKIP_REVIEW', 'id', 'Naskah Diterima (Tanpa Review)', 'Naskah Anda telah dikirim untuk proses copyediting', '<p>Yth. {$recipientName},</p>
<p>Dengan senang hati kami menginformasikan bahwa kami telah memutuskan menerima naskah Anda tanpa melalui proses review. Naskah Anda, {$submissionTitle}, telah memenuhi ketentuan jurnal, dan tidak perlu melewati proses tersebut. Kami senang menerbitkan karya Anda di {$contextName} dan terima kasih atas pilihan ANda memilih jurnal kami sebagai media publikasi karya Anda.</p>
Naskah Anda sekarang berstatus Akan terbit papa nomor {$contextName} dan membolehkan anda menambahkannya ke dalam daftar publikasi Anda. Kami menghargai kerja keras yang telah berhasil diterima dan selamat atas pencapaian Anda.</p>
<p>Naskah Anda selanjutnay akan melalui proses copy edit dan pengaturan format agar siap diterbitkan. </p>
<p>Kami akan segera mengirimkan panduan lanjutan.</p>
<p>Jika ada pertanyaan, silakan hubungi saya melalui <a href="{$authorSubmissionUrl}">dashboar naskah</a> Anda.</p>
<p>Hormat Kami,</p>
<p>{$signature}</p>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (73, 'EDITOR_DECISION_BACK_FROM_PRODUCTION', 'en', 'Submission Sent Back to Copyediting', 'Your submission has been sent back to copyediting', '<p>Dear {$recipientName},</p><p>Your submission, "{$submissionTitle}", has been sent back to the copyediting stage, where it will undergo further copyediting and formatting to prepare it for publication.</p><p>Occasionally, a submission is sent to the production stage before it is ready for the final galleys to be prepared for publication. Your submission is still forthcoming. I apologize for any confusion.</p><p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p><p>We will contact you if we need any further assistance.</p><p>Kind regards,</p><p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (74, 'EDITOR_DECISION_BACK_FROM_PRODUCTION', 'id', 'Naskah Dikirimkan Kembali ke Copyedit', 'Artikel anda telah dikirim kembali ke copyedit', '<p>Kepada Yth. {$recipientName},</p><p>Artikel anda, "{$submissionTitle}", telah dikirim kembali ke tahapan copyedit, dimana akan melewati copyedit dan format lebih lanjut untuk persiapan publikasi.</p><p>Kadang, artikel dikirim ke tahapan produksi sebelum siap untuk galley terakhir untuk persiapan publikasi. Artikel anda masih akan segera hadir. Saya minta maaf atas kekeliruan yang terjadi.</p><p>Jika anda mempunyai pertanyaa, silakan menghubungi saya dari <a href="{$authorSubmissionUrl}">dasbor pengiriman anda</a>.</p><p>Kami akan menghubungi anda jika membutuhkan bantuan lebih lanjut.</p><p>Hormat kami,</p><p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (75, 'EDITOR_DECISION_BACK_FROM_COPYEDITING', 'en', 'Submission Sent Back from Copyediting', 'Your submission has been sent back to review', '<p>Dear {$recipientName},</p><p>Your submission, "{$submissionTitle}", has been sent back to the review stage. It will undergo further review before it can be accepted for publication.</p><p>Occasionally, a decision to accept a submission will be recorded accidentally in our system and we must send it back to review. I apologize for any confusion this has caused. We will work to complete any further review quickly so that you have a final decision as soon as possible.</p><p>We will contact you if we need any further assistance.</p><p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p><p>Kind regards,</p><p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (76, 'EDITOR_DECISION_BACK_FROM_COPYEDITING', 'id', 'Naskah dikirim kembali dari Copyedit', 'Artikel anda telah dikirimkan kembali untuk direview', '<p>Kepada Yth. {$recipientName},</p><p>Artikel anda, "{$submissionTitle}", telah dikirimkan kembali ke tahap review. Proses ini akan melewati review lebih lanjut sebelum diterima untuk dipublikasikan.</p><p>Kadang, keputusan untuk menerima artikel akan tercatat secara tidak sengaja pada sistem kam dan kami harus mengirimkan kembali ke tahap review. Saya mohon maaf atas kekeliruan yang telah terjadi. Kami akan melengkapi review lebih lanjut dengan cepat sehingga anda akan mendapatkan keputusan akhir secepatnya.</p><p>Kami akan menghubungi anda jika kami membutuhkan bantuan lebih lanjut.</p><p>Jika anda mempunyai pertanyaan, silakan menghubungi saya dari <a href="{$authorSubmissionUrl}">dasbor pengiriman anda</a>.</p><p>Hormat kami,</p><p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (77, 'EDITOR_DECISION_CANCEL_REVIEW_ROUND', 'en', 'Review Round Cancelled', 'A review round for your submission has been cancelled', '<p>Dear {$recipientName},</p><p>We recently opened a new review round for your submission, "{$submissionTitle}". We are closing this review round now.</p><p>Occasionally, a decision to open a round of review will be recorded accidentally in our system and we must cancel this review round. I apologize for any confusion this may have caused.</p><p>We will contact you if we need any further assistance.</p><p>If you have any questions, please contact me from your <a href="{$authorSubmissionUrl}">submission dashboard</a>.</p><p>Kind regards,</p><p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (78, 'EDITOR_DECISION_CANCEL_REVIEW_ROUND', 'id', 'Putaran Review Dibatalkan', 'Putaran review untuk artikel anda telah dibatalkan', '<p>Kepada Yth. {$recipientName},</p><p>Saat ini kami telah membuka putaran review yang baru untuk artikel anda, "{$submissionTitle}". Kami sudah mendekati putaran review ini.</p><p>Kadang, keputusan untuk membuka putaran review tercatat secara tidak sengaja pada sistem kami dan kami harus menunda review round ini. Saya mohon maaf atas kekeliruan yang telah terjadi.</p><p>Kami akan menghubungi anda jika membutuhkan bantuan lebih lanjut.</p><p>Jika anda mempunyai pertanyaan, silakan menghubungi saya melalui <a href="{$authorSubmissionUrl}">dasbor pengiriman anda</a>.</p><p>Hormat kami,</p><p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (79, 'SUBSCRIPTION_NOTIFY', 'en', 'Subscription Notify', 'Subscription Notification', '{$recipientName}:<br />
<br />
You have now been registered as a subscriber in our online journal management system for {$contextName}, with the following subscription:<br />
<br />
{$subscriptionType}<br />
<br />
To access content that is available only to subscribers, simply log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />
<br />
Once you have logged in to the system you can change your profile details and password at any point.<br />
<br />
Please note that if you have an institutional subscription, there is no need for users at your institution to log in, since requests for subscription content will be automatically authenticated by the system.<br />
<br />
If you have any questions, please feel free to contact me.<br />
<br />
{$subscriptionSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (80, 'SUBSCRIPTION_NOTIFY', 'id', 'Notifikasi berlangganan', 'Pemberitahuan Langganan', '{$recipientName}:<br />
<br />
Anda sekarang telah terdaftar sebagai pelanggan di sistem manajemen jurnal online kami, {$contextName}, dengan jenis langganan:<br />
<br />
{$subscriptionType}<br />
<br />
Untuk mengakses konten yang hanya tersedia bagi pelanggan, silakan login ke sistem dengan menggunakan nama pengguna Anda, &quot;{$recipientUsername}&quot;.<br />
<br />
Setelah login, Anda dapat mengubah detail profil Anda dan sandi Anda kapanpun Anda kehendaki.<br />
<br />
Jika Anda memiliki langganan institusi, pengguna di institusi Anda tidak perlu login karena semua akses secara otomatis diotentikasi oleh sistem.<br />
<br />
Jika ada pertanyaan, silakan hubungi kami.<br />
<br />
{$subscriptionSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (84, 'SUBSCRIPTION_BEFORE_EXPIRY', 'id', 'Langganan Akan Segera Habis', 'Pemberitahuan Tanggal Berakhir Langganan', '{$recipientName}:<br />
<br />
Langganan {$contextName} Anda hampir berakhir.<br />
<br />
{$subscriptionType}<br />
Tanggal berakhir: {$expiryDate}<br />
<br />
Untuk terus memperoleh akses ke jurnal ini, silakan kunjungi website jurnal dan perbaharui langganan. Anda dapat login menggunakan nama pengguna Anda, &quot;{$recipientUsername}&quot;.<br />
<br />
Jika ada pertanyaan, silakan hubungi kami.<br />
<br />
{$subscriptionSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (85, 'SUBSCRIPTION_AFTER_EXPIRY', 'en', 'Subscription Expired', 'Subscription Expired', '{$recipientName}:<br />
<br />
Your {$contextName} subscription has expired.<br />
<br />
{$subscriptionType}<br />
Expiry date: {$expiryDate}<br />
<br />
To renew your subscription, please go to the journal website. You are able to log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />
<br />
If you have any questions, please feel free to contact me.<br />
<br />
{$subscriptionSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (86, 'SUBSCRIPTION_AFTER_EXPIRY', 'id', 'Langganan habis', 'Langganan Berakhir', '{$recipientName}:<br />
<br />
Langganan {$contextName} Anda telah berakhir.<br />
<br />
{$subscriptionType}<br />
Tanggal berakhir: {$expiryDate}<br />
<br />
Untuk memperbaharui langganan Anda, silakan kunjungi website jurnal. Anda dapat login dengan menggunakan nama pengguna Anda, &quot;{$recipientUsername}&quot;.<br />
<br />
Jika ada pertanyaan, silakan hubungi kami.<br />
<br />
{$subscriptionSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (87, 'SUBSCRIPTION_AFTER_EXPIRY_LAST', 'en', 'Subscription Expired Last', 'Subscription Expired - Final Reminder', '{$recipientName}:<br />
<br />
Your {$contextName} subscription has expired.<br />
Please note that this is the final reminder that will be emailed to you.<br />
<br />
{$subscriptionType}<br />
Expiry date: {$expiryDate}<br />
<br />
To renew your subscription, please go to the journal website. You are able to log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />
<br />
If you have any questions, please feel free to contact me.<br />
<br />
{$subscriptionSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (88, 'SUBSCRIPTION_AFTER_EXPIRY_LAST', 'id', 'Langganan habis terakhir', 'Langganan Berakhir - Pengingat Terakhir', '{$recipientName}:<br />
<br />
Langganan {$contextName} Anda telah berakhir.<br />
Ini adalah pengingat terakhir yang diemailkan kepada Anda.<br />
<br />
{$subscriptionType}<br />
Tanggal berakhir: {$expiryDate}<br />
<br />
Untuk memperbaharui langganan Anda, silakan kunjungi website jurnal. Anda dapat login dengan menggunakan nama pengguna Anda, &quot;{$recipientUsername}&quot;.<br />
<br />
Jika ada pertanyaan, silakan hubungi kami.<br />
<br />
{$subscriptionSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (89, 'SUBSCRIPTION_PURCHASE_INDL', 'en', 'Purchase Individual Subscription', 'Subscription Purchase: Individual', 'An individual subscription has been purchased online for {$contextName} with the following details.<br />
<br />
Subscription Type:<br />
{$subscriptionType}<br />
<br />
User:<br />
{$subscriberDetails}<br />
<br />
Membership Information (if provided):<br />
{$membership}<br />
<br />
To view or edit this subscription, please use the following URL.<br />
<br />
Subscription URL: {$subscriptionUrl}<br />
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (90, 'SUBSCRIPTION_PURCHASE_INDL', 'id', 'Beli Langganan Individu', 'Pembelian Langganan: Individu', 'Sebuah langganan individu telah dibeli online untuk {$contextName} dengan rincian berikut.<br />
<br />
Jenis Langganan:<br />
{$subscriptionType}<br />
<br />
Pengguna:<br />
{$subscriberDetails}<br />
<br />
Informasi Keanggotaan (jika ada):<br />
{$membership}<br />
<br />
Untuk melihat atau mengubah langganan ini, silakan gunakan URL berikut ini.<br />
<br />
URL Langganan: {$subscriptionUrl}<br />
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (91, 'SUBSCRIPTION_PURCHASE_INSTL', 'en', 'Purchase Institutional Subscription', 'Subscription Purchase: Institutional', 'An institutional subscription has been purchased online for {$contextName} with the following details. To activate this subscription, please use the provided Subscription URL and set the subscription status to ''Active''.<br />
<br />
Subscription Type:<br />
{$subscriptionType}<br />
<br />
Institution:<br />
{$institutionName}<br />
{$institutionMailingAddress}<br />
<br />
Domain (if provided):<br />
{$domain}<br />
<br />
IP Ranges (if provided):<br />
{$ipRanges}<br />
<br />
Contact Person:<br />
{$subscriberDetails}<br />
<br />
Membership Information (if provided):<br />
{$membership}<br />
<br />
To view or edit this subscription, please use the following URL.<br />
<br />
Subscription URL: {$subscriptionUrl}<br />
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (92, 'SUBSCRIPTION_PURCHASE_INSTL', 'id', 'Berlangganan Institusi', 'Pembelian Langganan: Institusi', 'Sebuah langganan institusi telah dibeli online untuk {$contextName} dengan rincian berikut. Untuk mengaktifkan langganan ini, silakan gunakan URL Langganan dan jadikan status langganan ke ''Aktif''.<br />
<br />
Jenis Langganan:<br />
{$subscriptionType}<br />
<br />
Institusi:<br />
{$institutionName}<br />
{$institutionMailingAddress}<br />
<br />
Domain (jika ada):<br />
{$domain}<br />
<br />
IP Ranges (jika ada):<br />
{$ipRanges}<br />
<br />
Contact Person:<br />
{$subscriberDetails}<br />
<br />
Informasi Keanggotaan (jika ada):<br />
{$membership}<br />
<br />
Untuk melihat atau mengubah langganan ini, silakan gunakan URL berikut ini.<br />
<br />
URL Langganan: {$subscriptionUrl}<br />
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (93, 'SUBSCRIPTION_RENEW_INDL', 'en', 'Renew Individual Subscription', 'Subscription Renewal: Individual', 'An individual subscription has been renewed online for {$contextName} with the following details.<br />
<br />
Subscription Type:<br />
{$subscriptionType}<br />
<br />
User:<br />
{$subscriberDetails}<br />
<br />
Membership Information (if provided):<br />
{$membership}<br />
<br />
To view or edit this subscription, please use the following URL.<br />
<br />
Subscription URL: {$subscriptionUrl}<br />
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (94, 'SUBSCRIPTION_RENEW_INDL', 'id', 'Perbaharui Langganan Individu', 'Pembaharuan Langganan: Individu', 'Sebuah langganan individu telah diperbaharui online untuk {$contextName} dengan rincian berikut.<br />
<br />
Jenis Langganan:<br />
{$subscriptionType}<br />
<br />
Pengguna:<br />
{$subscriberDetails}<br />
<br />
Informasi Keanggotaan (jika ada):<br />
{$membership}<br />
<br />
Untuk melihat atau mengubah langganan ini, silakan gunakan URL berikut ini.<br />
<br />
URL Langganan: {$subscriptionUrl}<br />
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (95, 'SUBSCRIPTION_RENEW_INSTL', 'en', 'Renew Institutional Subscription', 'Subscription Renewal: Institutional', 'An institutional subscription has been renewed online for {$contextName} with the following details.<br />
<br />
Subscription Type:<br />
{$subscriptionType}<br />
<br />
Institution:<br />
{$institutionName}<br />
{$institutionMailingAddress}<br />
<br />
Domain (if provided):<br />
{$domain}<br />
<br />
IP Ranges (if provided):<br />
{$ipRanges}<br />
<br />
Contact Person:<br />
{$subscriberDetails}<br />
<br />
Membership Information (if provided):<br />
{$membership}<br />
<br />
To view or edit this subscription, please use the following URL.<br />
<br />
Subscription URL: {$subscriptionUrl}<br />
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (127, 'SUBMISSION_SAVED_FOR_LATER', 'en', 'Submission Saved for Later', 'Resume your submission to {$contextName}', '<p>Dear {$recipientName},</p><p>Your submission details have been saved in our system, but it has not yet been submitted for consideration. You can return to complete your submission at any time by following the link below.</p><p><a href="{$submissionWizardUrl}">{$authorsShort} — "{$submissionTitle}"</a></p><hr><p>This is an automated email from <a href="{$contextUrl}">{$contextName}</a>.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (96, 'SUBSCRIPTION_RENEW_INSTL', 'id', 'Perbaharui Langganann Institusi', 'Pembaharuan Langganan: Institusi', 'Sebuah langganan institusi telah diperbaharui online untuk {$contextName} dengan rincian berikut.<br />
<br />
Jenis Langganan:<br />
{$subscriptionType}<br />
<br />
Institusi:<br />
{$institutionName}<br />
{$institutionMailingAddress}<br />
<br />
Domain (jika ada):<br />
{$domain}<br />
<br />
IP Ranges (jika ada):<br />
{$ipRanges}<br />
<br />
Contact Person:<br />
{$subscriberDetails}<br />
<br />
Informasi Keanggotaan (jika ada):<br />
{$membership}<br />
<br />
Untuk melihat atau mengubah langganan ini, silakan gunakan URL berikut ini.<br />
<br />
URL Langganan: {$subscriptionUrl}<br />
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (97, 'REVISED_VERSION_NOTIFY', 'en', 'Revised Version Notification', 'Revised Version Uploaded', '<p>Dear {$recipientName},</p><p>The author has uploaded revisions for the submission, <b>{$authorsShort} — {$submissionTitle}</b>. <p>As an assigned editor, we ask that you login and <a href="{$submissionUrl}">view the revisions</a> and make a decision to accept, decline or send the submission for further review.</p><br><br>—<br>This is an automated message from <a href="{$contextUrl}">{$contextName}</a>.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (98, 'REVISED_VERSION_NOTIFY', 'id', 'Notifikasi Versi Revisi', 'Versi Revisi telah Diunggah', '<p>Yth {$recipientName},</p><p>Penulis telah mengunggah revisi naskahnya, <b>{$authorsShort} — {$submissionTitle}</b>. <p>Sebagai.editorp, silakan login dan <a href="{$submissionUrl}">periksa revisinya</a> dan ambil keputusan apakah menerima, menolak, atau kirim.naskah untuk direview lebih lanjut.</p><br><br>—<br>Ini pesan otomatis dari <a href="{$contextUrl}">{$contextName}</a>.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (99, 'STATISTICS_REPORT_NOTIFICATION', 'en', 'Statistics Report Notification', 'Editorial activity for {$month}, {$year}', '
{$recipientName}, <br />
<br />
Your journal health report for {$month}, {$year} is now available. Your key stats for this month are below.<br />
<ul>
	<li>New submissions this month: {$newSubmissions}</li>
	<li>Declined submissions this month: {$declinedSubmissions}</li>
	<li>Accepted submissions this month: {$acceptedSubmissions}</li>
	<li>Total submissions in the system: {$totalSubmissions}</li>
</ul>
Login to the journal to view more detailed <a href="{$editorialStatsLink}">editorial trends</a> and <a href="{$publicationStatsLink}">published article stats</a>. A full copy of this month''s editorial trends is attached.<br />
<br />
Sincerely,<br />
{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (100, 'STATISTICS_REPORT_NOTIFICATION', 'id', 'Notifikasi Laporan Statistik', 'Kegiatan redaksi selama {$month}, {$year}', '
{$recipientName}, <br />
<br />
Laporan kondisi jurnal Anda untuk {$month}, {$year} sudah tersedia. Statistik utama Anda bulan ini tersaji sebagai berikut.<br />
<ul>
	<li>Naskah baru yang masuk bulan ini: {$newSubmissions}</li>
	<li>Naskah ditolak bulan ini: {$declinedSubmissions}</li>
	<li>Naskah yang diterima bulan ini: {$acceptedSubmissions}</li>
	<li>Total naskah dalam sistem: {$totalSubmissions}</li>
</ul>
Selengkapnya, login untuk melihat <a href="{$editorialStatsLink}">kecenderungan editorial</a> dan <a href="{$publicationStatsLink}">statistik artikel yang dipublikasikan</a>. Salinan lengkap trend bulan ini terlampir.<br />
<br />
Salam Hormat,<br />
{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (101, 'ANNOUNCEMENT', 'en', 'New Announcement', '{$announcementTitle}', '<b>{$announcementTitle}</b><br />
<br />
{$announcementSummary}<br />
<br />
Visit our website to read the <a href="{$announcementUrl}">full announcement</a>.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (102, 'ANNOUNCEMENT', 'id', 'Pengumuman Baru', '{$announcementTitle}', '<b>{$announcementTitle}</b><br />
<br />
{$announcementSummary}<br />
<br />
Kunjungi website kami untuk melihat <a href="{$announcementUrl}">pengumuman selengkapnya</a>.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (103, 'DISCUSSION_NOTIFICATION_SUBMISSION', 'en', 'Discussion (Submission)', 'A message regarding {$contextName}', 'Please enter your message.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (104, 'DISCUSSION_NOTIFICATION_SUBMISSION', 'id', 'Diskusi (Pengiriman Naskah)', 'Pesan terkait {$contextName}', 'Silakan tuliskan pesan Anda.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (105, 'DISCUSSION_NOTIFICATION_REVIEW', 'en', 'Discussion (Review)', 'A message regarding {$contextName}', 'Please enter your message.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (106, 'DISCUSSION_NOTIFICATION_REVIEW', 'id', 'Diskusi (Review)', 'Pesan terkait {$contextName}', 'Silakan tuliskan pesan Anda.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (107, 'DISCUSSION_NOTIFICATION_COPYEDITING', 'en', 'Discussion (Copyediting)', 'A message regarding {$contextName}', 'Please enter your message.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (108, 'DISCUSSION_NOTIFICATION_COPYEDITING', 'id', 'Diskusi (Copyedit)', 'Pesan terkait {$contextName}', 'Silakan tuliskan pesan Anda.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (109, 'DISCUSSION_NOTIFICATION_PRODUCTION', 'en', 'Discussion (Production)', 'A message regarding {$contextName}', 'Please enter your message.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (110, 'DISCUSSION_NOTIFICATION_PRODUCTION', 'id', 'Diskusi (Produksi)', 'Pesan terkait {$contextName}', 'Silakan tuliskan pesan Anda.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (111, 'COPYEDIT_REQUEST', 'en', 'Request Copyedit', 'Submission {$submissionId} is ready to be copyedited for {$contextAcronym}', '<p>Dear {$recipientName},</p><p>A new submission is ready to be copyedited:</p><p><a href"{$submissionUrl}">{$submissionId} — "{$submissionTitle}"</a><br />{$contextName}</p><p>Please follow these steps to complete this task:</p><ol><li>Click on the Submission URL below.</li><li>Open any files available under Draft Files and edit the files. Use the Copyediting Discussions area if you need to contact the editor(s) or author(s).</li><li>Save the copyedited file(s) and upload them to the Copyedited panel.</li><li>Use the Copyediting Discussions to notify the editor(s) that all files have been prepared, and that the Production process may begin.</li></ol><p>If you are unable to undertake this work at this time or have any questions, please contact me. Thank you for your contribution to {$contextName}.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (112, 'COPYEDIT_REQUEST', 'id', 'Permintaan Copyedit', 'Naskah {$submissionId} siap masuk ke tahap copyedit untuk {$contextAcronym}', '<p>Kepada Yth. {$recipientName},</p><p>Naskah baru sudah siap untuk dicopyedit:</p><p><a href"{$submissionUrl}">{$submissionId} — "{$submissionTitle}"</a><br />{$contextName}</p><p>Mohon ikuti langkah-langkah ini untuk menyelasaikan tugas ini:</p><ol><li>Klik URL naskah berikut.</li><li>Buka file yang tersedia di bawah File Draft dan edit file tersebut. Gunakan area Diskusi Copyedit jika anda ingin mengontak editor atau penulis.</li><li>Simpan file yang sudah dicopyedit dan unggah ke panel Copyedit.</li><li>Gunakan Diskusi Copyedit untuk mengingatkan editor bahwa semua file telah siap, dan proses Produksi dapat dimulai.</li></ol><p>Jika anda tidak dapat melakukan tugas ini sekarang atau ada pertanyaan lebih lanjut, silakan hubungi saya. Terima kasih atas kontribusi anda pada {$contextName}.</p><p>Hormat kami,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (113, 'EDITOR_ASSIGN_SUBMISSION', 'en', 'Assign Editor', 'You have been assigned as an editor on a submission to {$contextName}', '<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the editorial process.</p><p><a href="{$submissionUrl}">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>If you find the submission to be relevant for {$contextName}, please forward the submission to the review stage by selecting "Send to Review" and then assign reviewers by clicking "Add Reviewer".</p><p>If the submission is not appropriate for this journal, please decline the submission.</p><p>Thank you in advance.</p><p>Kind regards,</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (114, 'EDITOR_ASSIGN_SUBMISSION', 'id', 'Menugaskan Editor', 'Anda telah ditugaskan sebagai editor untuk naskah pada {$contextName}', '<p>Yth. {$recipientName},</p><p>Naskah berikut telah ditugaskan kepada Anda untuk diperiksa melalui proses editorial.</p><p><a href="{$submissionUrl}">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Jika telah sesuai dengan {$contextName}, lanjutkan naskah tersebut ke tahap dengan memilih "Kirim ke Taha Review" lalu tugaskan seorang mitra bestari dengan mengklik "Tambahkan Mitra Bestari".</p><p>Jika tidak sesuai dengan ketentuan jurnal, silakan naskah ditolak.</p><p>Terima kasih.</p><p>Salam hormat,</p>{$contextSignature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (115, 'EDITOR_ASSIGN_REVIEW', 'en', 'Assign Editor', 'You have been assigned as an editor on a submission to {$contextName}', '<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the peer review process.</p><p><a href="{$submissionUrl}">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please login to <a href="{$submissionUrl}">view the submission</a> and assign qualified reviewers. You can assign a reviewer by clicking "Add Reviewer".</p><p>Thank you in advance.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (116, 'EDITOR_ASSIGN_REVIEW', 'id', 'Menugaskan Editor', 'Anda telah ditugaskan sebagai editor untuk naskah pada {$contextName}', '<p>Yth {$recipientName},</p><p>Naskah berikut telah ditugaskan kepada Anda untuk ditangani selama proses review.</p><p><a href="{$submissionUrl}">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstrak</b></p>{$submissionAbstract}<p>Silakan login untuk <a href="{$submissionUrl}">melihat naskah</a> dan tugaskan mitra bestari yang sesuai kualifikasi. Anda bisa menugaskan seorang mitra bestari dengan mengklik "Tambah Mitra Bestari".</p><p>Terima kasih.</p><p>Salam Hormat,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (117, 'EDITOR_ASSIGN_PRODUCTION', 'en', 'Assign Editor', 'You have been assigned as an editor on a submission to {$contextName}', '<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the production stage.</p><p><a href="{$submissionUrl}">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please login to <a href="{$submissionUrl}">view the submission</a>. Once production-ready files are available, upload them under the <strong>Publication > Galleys</strong> section. Then schedule the work for publication by clicking the <strong>Schedule for Publication</strong> button.</p><p>Thank you in advance.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (118, 'EDITOR_ASSIGN_PRODUCTION', 'id', 'Menugaskan Editor', 'Anda telah ditugaskan sebagai editor untuk naskah pada {$contextName}', '<p>Yth {$recipientName},</p><p>Naskah berikut telah ditugaskan kepada Anda untuk ditangani selama tahap produksi.</p><p><a href="{$submissionUrl}">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstrak</b></p>{$submissionAbstract}<p>Silakan login untuk <a href="{$submissionUrl}">melihat naskah</a>. Bila file produksi telah siap, silakan unggah ke bagian <strong>Publikasi > Galei</strong>. Selanjutnya jadwalkan naskah untuk diterbitkan dengan mengklik tombol <strong>Jadwalkan untuk Diterbitkan</strong>.</p><p>Terima kasih.</p><p>Salam Hormat,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (119, 'LAYOUT_REQUEST', 'en', 'Ready for Production', 'Submission {$submissionId} is ready for production at {$contextAcronym}', '<p>Dear {$recipientName},</p><p>A new submission is ready for layout editing:</p><p><a href="{$submissionUrl}">{$submissionId} — {$submissionTitle}</a><br />{$contextName}</p><ol><li>Click on the Submission URL above.</li><li>Download the Production Ready files and use them to create the galleys according to the journal''s standards.</li><li>Upload the galleys to the Publication section of the submission.</li><li>Use the  Production Discussions to notify the editor that the galleys are ready.</li></ol><p>If you are unable to undertake this work at this time or have any questions, please contact me. Thank you for your contribution to this journal.</p><p>Kind regards,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (120, 'LAYOUT_REQUEST', 'id', 'Siap untuk Produksi', 'Naskah {$submissionId} siap masuk ke tahap produksi pada {$contextAcronym}', '<p>Yth. {$recipientName},</p><p>Naskah baru telah siap proses layout editing:</p><p><a href="{$submissionUrl}">{$submissionId} — {$submissionTitle}</a><br />{$contextName}</p><ol><li>Klik URL Naskah di atas.</li><li>Unduh file Siap Cetak dan gunakan untuk membuat galley sesuai aturan jurnal.</li><li>Unggah galley ke bagian Publikasi naskah.</li><li>Gunakan fitur Diskusi Produksi untuk memberitahu editor bahwa file galley sudah siap.</li></ol><p>Jika tidak bisa mengerjakan sekarang atau ada pertanyaan, silakan hubungi saya. Terima kasih atas kontribusinya kepada jurnal ini.</p><p>Salam hormat,</p>{$signature}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (121, 'LAYOUT_COMPLETE', 'en', 'Galleys Complete', 'Galleys Complete', '<p>Dear {$recipientName},</p><p>Galleys have now been prepared for the following submission and are ready for final review.</p><p><a href="{$submissionUrl}">{$submissionTitle}</a><br />{$contextName}</p><p>If you have any questions, please contact me.</p><p>Kind regards,</p><p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (122, 'LAYOUT_COMPLETE', 'id', 'Galei Selesai', 'Galley Selesai', '<p>Yang terhormat {$recipientName},</p><p>Galley kini telah disiapkan untuk pengiriman berikut dan siap untuk peninjauan akhir.</p><p><a href="{$submissionUrl}">{$submissionTitle}</a><br />{$contextName}</p><p>Jika Anda memiliki pertanyaan, silakan hubungi saya.</p><p>Salam hormat,</p><p>{$signature}</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (123, 'VERSION_CREATED', 'en', 'Version Created', 'A new version was created for "{$submissionTitle}"', '<p>Dear {$recipientName}, </p><p>This is an automated message to inform you that a new version of your submission, "{$submissionTitle}", was created. You can view this version from your submission dashboard at the following link:</p><p><a href="{$submissionUrl}">"{$submissionTitle}"</a></p><hr><p>This is an automatic email sent from <a href="{$contextUrl}">{$contextName}</a>.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (124, 'VERSION_CREATED', 'id', 'Versi Dibuat', 'Versi terbaru sudah dibuat untuk "{$submissionTitle}"', '<p>Kepada Yth. {$recipientName}, </p><p>Ini adalah pesan otomatis untuk memberitahukan kepada anda bahwa versi terbaru dari naskah anda, "{$submissionTitle}", telah dibuat. Anda dapat melihat versi ini dari dasbor pengiriman anda pada tautan berikut:</p><p><a href="{$submissionUrl}">"{$submissionTitle}"</a></p><hr><p>Ini adalah email otomatis yang dikirim dari <a href="{$contextUrl}">{$contextName}</a>.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (125, 'EDITORIAL_REMINDER', 'en', 'Editorial Reminder', 'Outstanding editorial tasks for {$contextName}', '<p>Dear {$recipientName},</p><p>You are currently assigned to {$numberOfSubmissions} submissions in <a href="{$contextUrl}">{$contextName}</a>. The following submissions are <b>waiting for your response</b>.</p>{$outstandingTasks}<p>View all of your assignments in your <a href="{$submissionsUrl}">submission dashboard</a>.</p><p>If you have any questions about your assignments, please contact {$contactName} at {$contactEmail}.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (126, 'EDITORIAL_REMINDER', 'id', 'Pengingat Editorial', 'Tugas editorial yang belum diselesaikan untuk {$contextName}', '<p>Kepada Yth. {$recipientName},</p><p>Saat ini anda ditugaskan untuk menangani{$numberOfSubmissions} artikel yang masuk pada <a href="{$contextUrl}">{$contextName}</a>. Artikel tersebut <b>menunggu respon dari anda</b>.</p>{$outstandingTasks}<p>Lihat selluruh tugas anda pada <a href="{$submissionsUrl}">dasbor pengiriman</a>.</p><p>Jika anda memiliki pertanyaan tentang tugas anda, silakan kontak {$contactName} pada {$contactEmail}.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (128, 'SUBMISSION_SAVED_FOR_LATER', 'id', 'Naskah Telah Disimpan untuk Dikirim Nanti', 'Lanjutkan pengiriman artikel anda ke {$contextName}', '<p>Kepada Yth. {$recipientName},</p><p>Detail pengiriman naskah anda telah disimpan di sistem kami, namun belum dikirim karena pertimbangan tertentu. Anda dapat kembali untuk melengkapinya kapan saja dengan mengikuti link di bawah ini. </p><p><a href="{$submissionWizardUrl}">{$authorsShort} — "{$submissionTitle}"</a></p><hr><p>Ini merupakan email otomatis dari <a href="{$contextUrl}">{$contextName}</a>.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (129, 'SUBMISSION_NEEDS_EDITOR', 'en', 'Submission Needs Editor', 'A new submission needs an editor to be assigned: "{$submissionTitle}"', '<p>Dear {$recipientName},</p><p>The following submission has been submitted and there is no editor assigned.</p><p><a href="{$submissionUrl}">"{$submissionTitle}"</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please assign an editor who will be responsible for the submission by clicking the title above and assigning an editor under the Participants section.</p><hr><p>This is an automated email from <a href="{$contextUrl}">{$contextName}</a>.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (130, 'SUBMISSION_NEEDS_EDITOR', 'id', 'Naskah Membutuhkan Editor', 'Sebuah naskah baru membutuhkan editor yang ditugaskan: "{$submissionTitle}"', '<p>Kepada Yth. {$recipientName},</p><p>Naskah berikut telah dikirim dan belum ada editor yang ditugaskan.</p><p><a href="{$submissionUrl}">"{$submissionTitle}"</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Mohon tugaskan editor yang akan bertanggung jawab pada naskah ini dengan mengklik judul di atas dan menugaskan editor di bawah bagian Participants.</p><hr><p>Ini adalah email otomatis dari <a href="{$contextUrl}">{$contextName}</a>.</p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (131, 'PAYMENT_REQUEST_NOTIFICATION', 'en', 'Payment Request', 'Payment Request Notification', '<p>Dear {$recipientName},</p><p>Congratulations on the acceptance of your submission, {$submissionTitle}, to {$contextName}. Now that your submission has been accepted, we would like to request payment of the publication fee.</p><p>This fee covers the production costs of bringing your submission to publication. To make the payment, please visit <a href="{$queuedPaymentUrl}">{$queuedPaymentUrl}</a>.</p><p>If you have any questions, please see our <a href="{$submissionGuidelinesUrl}">Submission Guidelines</a></p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (132, 'PAYMENT_REQUEST_NOTIFICATION', 'id', 'Permintaan Pembayaran', 'Notifikasi Permintaan Pembayaran', '<p>Yth {$recipientName},</p><p>Selamat atas diterimanya naskah Anda, {$submissionTitle}, pada {$contextName}. Saat ini, naskah terlah diterima, kami meminta Anda untuk melakukan pembayaran biaya publikasi.</p><p>Biaya ini mencakup biaya produksi hingga publikasi. Untuk melakukan pembayaran, buka halaman <a href="{$queuedPaymentUrl}">{$queuedPaymentUrl}</a>.</p><p>Jika ada pertanyaan, silakan buka <a href="{$submissionGuidelinesUrl}">Panduan Naskah</a></p>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (133, 'CHANGE_EMAIL', 'en', 'Change Email Address Invitation', 'Confirm account contact email change request', '<p>Dear {$recipientName},</p><p>You are receiving this email because someone has requested a change of your email to {$newEmail}.</p><p>If you have made this request please <a href="{$acceptInvitationUrl}">confirm</a> the email change.</p><p>You can always <a href="{$declineInvitationUrl}">reject</a> this email change.</p><p>Please feel free to contact me with any questions about the submission or the review process.</p><p>Kind regards,</p>{$siteContactName}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (134, 'CHANGE_EMAIL', 'id', 'Undangan Perubahan Alamat Email', 'Konfirmasi permintaan perubahan email kontak akun', '<p>Kepada Yth. {$recipientName},</p><p>Anda menerima email ini karena seseorang meminta perubahan pada email anda ke {$newEmail}.</p><p>Jika anda yang meminta hal ini tolong <a href="{$acceptInvitationUrl}">konfirmasi</a> perubahan email ini.</p><p>Anda selalu dapat <a href="{$declineInvitationUrl}">menolak</a> perubahan email.</p><p>Jangan sungkan menghubungi saya jika ada pertanyaan tentang proses pengiriman artikel atau review.</p><p>Hormat kami,</p>{$siteContactName}');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (135, 'ORCID_COLLECT_AUTHOR_ID', 'en', 'orcidCollectAuthorId', 'Submission ORCID', 'Dear {$recipientName},<br/>
<br/>
You have been listed as an author on a manuscript submission to {$contextName}.<br/>
To confirm your authorship, please add your ORCID id to this submission by visiting the link provided below.<br/>
<br/>
<a href="{$authorOrcidUrl}"><img id="orcid-id-logo" src="https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png" width=''16'' height=''16'' alt="ORCID iD icon" style="display: block; margin: 0 .5em 0 0; padding: 0; float: left;"/>Register or connect your ORCID iD</a><br/>
<br/>
<br>
<a href="{$orcidAboutUrl}">More information about ORCID at {$contextName}</a><br/>
<br/>
If you have any questions, please contact me.<br/>
<br/>
{$principalContactSignature}<br/>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (136, 'ORCID_COLLECT_AUTHOR_ID', 'id', '', 'ORCID Naskah', 'Yang Kami Hormati {$recipientName},<br/>
<br/>
Anda telah terdaftar sebagai penulis naskah{$contextName}.<br/>
Untuk mengonfirmasi kepenulisan tersebut, tambahkanlah id ORCID Anda pada naskah tersebut dengan membuka tautan berikut ini.<br/>
<br/>
<a href="{$authorOrcidUrl}"><img id="orcid-id-logo" src="https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png" width=''16'' height=''16'' alt="ORCID iD icon" style="display: block; margin: 0 .5em 0 0; padding: 0; float: left;"/>Register atau hubungkan iD ORCID Anda</a><br/>
<br/>
<br>
<a href="{$orcidAboutUrl}">Informasi selengkapnya tentang ORCID pada {$contextName}</a><br/>
<br/>
Bila ada pertanyaan, silakan hubungi kami.<br/>
<br/>
{$principalContactSignature}<br/>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (137, 'ORCID_REQUEST_AUTHOR_AUTHORIZATION', 'en', 'orcidRequestAuthorAuthorization', 'Requesting ORCID record access', 'Dear {$recipientName},<br>
<br>
You have been listed as an author on the manuscript submission "{$submissionTitle}" to {$contextName}.
<br>
<br>
Please allow us to add your ORCID id to this submission and also to add the submission to your ORCID profile on publication.<br>
Visit the link to the official ORCID website, login with your profile and authorize the access by following the instructions.<br>
<br>
<a href="{$authorOrcidUrl}" style="display: inline-flex; align-items: center; background-color: white; text-align: center; padding: 10px 20px; text-decoration: none; border-radius: 5px; border: 2px solid #d7d4d4;"><img id="orcid-id-logo" src="https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png" width=''16'' height=''16'' alt="ORCID iD icon" style="display: block; margin: 0 .5em 0 0; padding: 0; float: left;"/>Register or Connect your ORCID iD</a><br/>
<br>
<br>
Click here to verify your account with ORCID: <a href="{$authorOrcidUrl}">{$authorOrcidUrl}.</a>
<br>
<br>
<a href="{$orcidAboutUrl}">More about ORCID at {$contextName}</a><br/>
<br>
<br>
If you have any questions, please contact me.<br>
<br>
{$principalContactSignature}<br>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (138, 'ORCID_REQUEST_AUTHOR_AUTHORIZATION', 'id', '', 'Meminta akses rekaman ORCID', 'Yang Kami Hormati {$recipientName},<br/>
<br/>
Anda telah terdaftar sebagai penulis naskah{$contextName}.<br/>
Untuk mengonfirmasi kepenulisan tersebut, tambahkanlah id ORCID Anda pada naskah tersebut dengan membuka tautan berikut ini.<br/>
<br/>
<a href="{$authorOrcidUrl}"><img id="orcid-id-logo" src="https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png" width=''16'' height=''16'' alt="ORCID iD icon" style="display: block; margin: 0 .5em 0 0; padding: 0; float: left;"/>Register atau hubungkan iD ORCID Anda</a><br/>
<br/>
<br>
<a href="{$orcidAboutUrl}">Informasi selengkapnya tentang ORCID pada {$contextName}</a><br/>
<br/>
Bila ada pertanyaan, silakan hubungi kami.<br/>
<br/>
{$principalContactSignature}<br/>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (139, 'USER_ROLE_ASSIGNMENT_INVITATION', 'en', 'User Invited to Role Notification', 'You are invited to new roles', '<div class=''email-container''>    <div class=''email-header''>        <h2>Invitation to New Role</h2>    </div>    <div class=''email-content''>        <p>Dear {$recipientName},</p>        <p>In light of your expertise, you have been invited by {$inviterName} to take on new roles at {$contextName}</p>        <p>At {$contextName}, we value your privacy. As such, we have taken steps to ensure that we are fully GDPR compliant. These steps include you being accountable to enter your own data and choosing who can see what information. For additional information on how we handled your data, please refer to our Privacy Policy.</p>        <div>{$existingRoles}</div>        <div>{$rolesAdded}</div>        <p>On accepting the invite, you will be redirected to {$contextName}.</p>        <p>Feel free to contact me with any questions about the process.</p>        <table class=''btn-wrap'' role=''presentation'' border=''0'' cellpadding=''0'' cellspacing=''10''>            <tr><td class=''btn-cell btn-accept''  bgcolor=''#28a745''><a class=''btn'' href=''{$acceptUrl}''>Accept Invitation</a></td></tr>            <tr><td class=''btn-cell btn-decline'' bgcolor=''#dc3545''><a class=''btn'' href=''{$declineUrl}''>Decline Invitation</a></td></tr>        </table>        <p>Kind regards,</p>        <p>{$contextName}</p>    </div></div>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (140, 'USER_ROLE_ASSIGNMENT_INVITATION', 'id', '', '', '');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (141, 'USER_ROLE_END', 'en', 'User Role Ended Notification', 'You have been removed from a role', '<div class=''email-container''>    <div class=''email-header''>        <h2>Removed from a Role</h2>    </div>    <div class=''email-content''>        <p>Dear {$recipientName},</p>        <p>Thank you very much for your participation in the role of {$roleRemoved} at {$contextName}.</p>        <p>This is a notice to let you know that you have been removed from the following role at {$contextName}: <b>{$roleRemoved}</b>.</p>        <p>Your account with {$contextName} is still active and any other roles you previously held are still active.</p>        <p>Feel free to contact me with any questions about the process.</p>        <p>Kind regards,</p>        <p>{$contextName}</p>    </div></div>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (142, 'USER_ROLE_END', 'id', 'Notifikasi Peran Pengguna telah Berakhir', 'Anda telah dihapus dari sebuah peran', '<div class=''email-container''>    <div class=''email-header''>        <h2>Dihapus dari Peran</h2>    </div>    <div class=''email-content''>        <p>Kepada Yth. {$recipientName},</p>        <p>Terima kasih banyak atas partisipasi anda pada peranan {$roleRemoved} di {$contextName}.</p>        <p>Ini adalah pemberitahuan bahwa anda telah dihapus dari peran berikut pada {$contextName}: <b>{$roleRemoved}</b>.</p>        <p>Akun anda pada {$contextName} masih aktif dan peran lain yang sebelumnya ada masih tetap aktif.</p>        <p>Jangan sungkan untuk menghubungi kami jika ada pertanyaan mengenai proses ini.</p>        <p>Hormat kami,</p>        <p>{$contextName}</p>    </div></div><style>{$emailTemplateStyle}</style>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (143, 'USER_ROLE_MASTHEAD_UPDATE', 'en', 'User Role Masthead Visibility Update Notification', 'Your journal masthead visibility has been updated', '<div class=''email-container''>    <div class=''email-header''>        <h2>Updated role masthead visibility</h2>    </div>    <div class=''email-content''>        <p>Dear {$recipientName},</p>        <p>Your journal masthead visibility for the role {$roleNameAndDates} in {$contextName} has been updated.</p>        <p>New setting: {$appearOnMasthead}</p>        <p>If you have questions about this change, please contact the journal manager.</p>        <p>Kind regards,</p>        <p>{$contextName}</p>    </div></div>');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (144, 'USER_ROLE_MASTHEAD_UPDATE', 'id', '', '', '');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (145, 'ORCID_REQUEST_UPDATE_SCOPE', 'en', 'orcidRequestUpdateScope', 'Requesting updated ORCID record access', 'Dear {$recipientName},<br>
<br>
You are listed as a contributor (author or reviewer) on the manuscript submission "{$submissionTitle}" to {$contextName}.
<br>
<br>
You have previously authorized {$contextName} to list your ORCID id on the site, and we require updateded permissions to add your contribution to your ORCID profile.<br>
Visit the link to the official ORCID website, login with your profile and authorize the access by following the instructions.<br>
<br>
<a href="{$authorOrcidUrl}" style="display: inline-flex; align-items: center; background-color: white; text-align: center; padding: 10px 20px; text-decoration: none; border-radius: 5px; border: 2px solid #d7d4d4;"><img id="orcid-id-logo" src="https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png" width=''16'' height=''16'' alt="ORCID iD icon" style="display: block; margin: 0 .5em 0 0; padding: 0; float: left;"/>Register or Connect your ORCID iD</a><br/>
<br>
<br>
Click here to update your account with ORCID: <a href="{$authorOrcidUrl}">{$authorOrcidUrl}.</a>
<br>
<br>
<a href="{$orcidAboutUrl}">More about ORCID at {$contextName}</a><br/>
<br>
<br>
If you have any questions, please contact me.<br>
<br>
{$principalContactSignature}<br>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (146, 'ORCID_REQUEST_UPDATE_SCOPE', 'id', 'orcidRequestUpdateScope', 'Meminta akses rekod ORCID yang terbaru', 'Kepada Yth. {$recipientName},<br>
<br>
Anda terdaftar sebagai kontributor (penulis atau reviewer) pada artikel "{$submissionTitle}" pada {$contextName}.
<br>
<br>
Anda sebelumnya mengotorisasi {$contextName} untuk mendaftarkan ID ORCID anda pada situs, dan kami meminta ijin terbaru untuk menambahkan kontribusi pada profil ORCID anda.<br>
Kunjungi tautan ke situs ORCID yang resmi, login ke profil anda dan ijinkan akses dengan mengikuti petunjung berikut.<br>
<br>
<a href="{$authorOrcidUrl}" style="display: inline-flex; align-items: center; background-color: white; text-align: center; padding: 10px 20px; text-decoration: none; border-radius: 5px; border: 2px solid #d7d4d4;"><img id="orcid-id-logo" src="https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png" width=''16'' height=''16'' alt="ORCID iD icon" style="display: block; margin: 0 .5em 0 0; padding: 0; float: left;"/>Daftar atau Hubungkan ID ORCID anda</a><br/>
<br>
<br>
Klik di sini untuk memperbarui akun anda pada ORCID: <a href="{$authorOrcidUrl}">{$authorOrcidUrl}.</a>
<br>
<br>
<a href="{$orcidAboutUrl}">Lebih lanjut tentang ORCID pada {$contextName}</a><br/>
<br>
<br>
Jika anda mempunyai pertanyaan lebih lanjut, silakan hubungi saya.<br>
<br>
{$principalContactSignature}<br>
');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (147, 'MANUAL_PAYMENT_NOTIFICATION', 'en', 'Manual Payment Notify', 'Manual Payment Notification', 'A manual payment needs to be processed for the journal {$contextName} and the user &quot;{$senderUsername}&quot;.<br />
<br />
The item being paid for is &quot;{$paymentName}&quot;.<br />
The cost is {$paymentAmount} ({$paymentCurrencyCode}).<br />
<br />
This email was generated by Open Journal Systems'' Manual Payment plugin.');
INSERT INTO public.email_templates_default_data (email_templates_default_data_id, email_key, locale, name, subject, body) VALUES (148, 'MANUAL_PAYMENT_NOTIFICATION', 'id', 'Notifikasi Pembayaran Manual', 'Notifikasi Pembayaran Manual', 'Pembayaran manual harus diproses untuk jurnal {$contextName} dan pengguna &quot;{$senderUsername}&quot;.<br />
<br />
Item yang akan dibayar adalah &quot;{$paymentName}&quot;.<br />
Biayanya {$paymentAmount} ({$paymentCurrencyCode}).<br />
<br />
Email ini dibuat oleh plugin Pembayaran Manual OJS.');


--
-- Data for Name: filter_groups; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (1, 'issue=>crossref-xml', 'plugins.importexport.crossref.displayName', 'plugins.importexport.crossref.description', 'class::classes.issue.Issue[]', 'xml::schema(https://www.crossref.org/schemas/crossref5.4.0.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (2, 'article=>crossref-xml', 'plugins.importexport.crossref.displayName', 'plugins.importexport.crossref.description', 'class::classes.submission.Submission[]', 'xml::schema(https://www.crossref.org/schemas/crossref5.4.0.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (3, 'issue=>datacite-xml', 'plugins.importexport.datacite.displayName', 'plugins.importexport.datacite.description', 'class::classes.issue.Issue', 'xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (4, 'article=>datacite-xml', 'plugins.importexport.datacite.displayName', 'plugins.importexport.datacite.description', 'class::classes.submission.Submission', 'xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (5, 'galley=>datacite-xml', 'plugins.importexport.datacite.displayName', 'plugins.importexport.datacite.description', 'class::lib.pkp.classes.galley.Galley', 'xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (6, 'article=>dc11', 'plugins.metadata.dc11.articleAdapter.displayName', 'plugins.metadata.dc11.articleAdapter.description', 'class::classes.submission.Submission', 'metadata::APP\plugins\metadata\dc11\schema\Dc11Schema(ARTICLE)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (7, 'article=>doaj-xml', 'plugins.importexport.doaj.displayName', 'plugins.importexport.doaj.description', 'class::classes.submission.Submission[]', 'xml::schema(plugins/importexport/doaj/doajArticles.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (8, 'article=>doaj-json', 'plugins.importexport.doaj.displayName', 'plugins.importexport.doaj.description', 'class::classes.submission.Submission', 'primitive::string');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (9, 'article=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::classes.submission.Submission[]', 'xml::schema(plugins/importexport/native/native.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (10, 'native-xml=>article', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::classes.submission.Submission[]');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (11, 'issue=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::classes.issue.Issue[]', 'xml::schema(plugins/importexport/native/native.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (12, 'native-xml=>issue', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::classes.issue.Issue[]');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (13, 'issuegalley=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::classes.issue.IssueGalley[]', 'xml::schema(plugins/importexport/native/native.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (14, 'native-xml=>issuegalley', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::classes.issue.IssueGalley[]');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (15, 'author=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::classes.author.Author[]', 'xml::schema(plugins/importexport/native/native.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (16, 'native-xml=>author', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::classes.author.Author[]');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (17, 'SubmissionFile=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::lib.pkp.classes.submissionFile.SubmissionFile', 'xml::schema(plugins/importexport/native/native.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (18, 'native-xml=>SubmissionFile', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::lib.pkp.classes.submissionFile.SubmissionFile[]');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (19, 'article-galley=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::lib.pkp.classes.galley.Galley', 'xml::schema(plugins/importexport/native/native.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (20, 'native-xml=>ArticleGalley', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::lib.pkp.classes.galley.Galley[]');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (21, 'publication=>native-xml', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'class::classes.publication.Publication', 'xml::schema(plugins/importexport/native/native.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (22, 'native-xml=>Publication', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(plugins/importexport/native/native.xsd)', 'class::classes.publication.Publication[]');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (23, 'article=>pubmed-xml', 'plugins.importexport.pubmed.displayName', 'plugins.importexport.pubmed.description', 'class::classes.submission.Submission[]', 'xml::dtd');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (24, 'user=>user-xml', 'plugins.importexport.users.displayName', 'plugins.importexport.users.description', 'class::PKP\user\User[]', 'xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (25, 'user-xml=>user', 'plugins.importexport.users.displayName', 'plugins.importexport.users.description', 'xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)', 'class::PKP\user\User[]');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (26, 'usergroup=>user-xml', 'plugins.importexport.users.displayName', 'plugins.importexport.users.description', 'class::PKP\userGroup\UserGroup[]', 'xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)');
INSERT INTO public.filter_groups (filter_group_id, symbolic, display_name, description, input_type, output_type) VALUES (27, 'user-xml=>usergroup', 'plugins.importexport.native.displayName', 'plugins.importexport.native.description', 'xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)', 'class::PKP\userGroup\UserGroup[]');


--
-- Data for Name: filters; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (1, 1, NULL, 'Crossref XML issue export', 'APP\plugins\generic\crossref\filter\IssueCrossrefXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (2, 2, NULL, 'Crossref XML article export', 'APP\plugins\generic\crossref\filter\ArticleCrossrefXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (3, 3, NULL, 'DataCite XML export', 'APP\plugins\generic\datacite\filter\DataciteXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (4, 4, NULL, 'DataCite XML export', 'APP\plugins\generic\datacite\filter\DataciteXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (5, 5, NULL, 'DataCite XML export', 'APP\plugins\generic\datacite\filter\DataciteXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (6, 6, NULL, 'Extract metadata from a(n) Submission', 'APP\plugins\metadata\dc11\filter\Dc11SchemaArticleAdapter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (7, 7, NULL, 'DOAJ XML export', 'APP\plugins\importexport\doaj\filter\DOAJXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (8, 8, NULL, 'DOAJ JSON export', 'APP\plugins\importexport\doaj\filter\DOAJJsonFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (9, 9, NULL, 'Native XML submission export', 'APP\plugins\importexport\native\filter\ArticleNativeXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (10, 10, NULL, 'Native XML submission import', 'APP\plugins\importexport\native\filter\NativeXmlArticleFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (11, 11, NULL, 'Native XML issue export', 'APP\plugins\importexport\native\filter\IssueNativeXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (12, 12, NULL, 'Native XML issue import', 'APP\plugins\importexport\native\filter\NativeXmlIssueFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (13, 13, NULL, 'Native XML issue galley export', 'APP\plugins\importexport\native\filter\IssueGalleyNativeXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (14, 14, NULL, 'Native XML issue galley import', 'APP\plugins\importexport\native\filter\NativeXmlIssueGalleyFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (15, 15, NULL, 'Native XML author export', 'APP\plugins\importexport\native\filter\AuthorNativeXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (16, 16, NULL, 'Native XML author import', 'APP\plugins\importexport\native\filter\NativeXmlAuthorFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (17, 18, NULL, 'Native XML submission file import', 'APP\plugins\importexport\native\filter\NativeXmlArticleFileFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (18, 17, NULL, 'Native XML submission file export', 'PKP\plugins\importexport\native\filter\SubmissionFileNativeXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (19, 19, NULL, 'Native XML representation export', 'APP\plugins\importexport\native\filter\ArticleGalleyNativeXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (20, 20, NULL, 'Native XML representation import', 'APP\plugins\importexport\native\filter\NativeXmlArticleGalleyFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (21, 21, NULL, 'Native XML Publication export', 'APP\plugins\importexport\native\filter\PublicationNativeXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (22, 22, NULL, 'Native XML publication import', 'APP\plugins\importexport\native\filter\NativeXmlPublicationFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (23, 23, NULL, 'APP\plugins\importexport\pubmed\filter\ArticlePubMedXmlFilter', 'APP\plugins\importexport\pubmed\filter\ArticlePubMedXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (24, 24, NULL, 'User XML user export', 'PKP\plugins\importexport\users\filter\PKPUserUserXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (25, 25, NULL, 'User XML user import', 'PKP\plugins\importexport\users\filter\UserXmlPKPUserFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (26, 26, NULL, 'Native XML user group export', 'PKP\plugins\importexport\users\filter\UserGroupNativeXmlFilter', 0, NULL, 0);
INSERT INTO public.filters (filter_id, filter_group_id, context_id, display_name, class_name, is_template, parent_filter_id, seq) VALUES (27, 27, NULL, 'Native XML user group import', 'PKP\plugins\importexport\users\filter\NativeXmlUserGroupFilter', 0, NULL, 0);


--
-- Data for Name: genre_settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (1, 1, 'id', 'name', 'File Utama Naskah', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (2, 2, 'id', 'name', 'Instrumen Penelitian', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (3, 3, 'id', 'name', 'Bahan Penelitian', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (4, 4, 'id', 'name', 'Hasil Penelitian', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (5, 5, 'id', 'name', 'Transkrip', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (6, 6, 'id', 'name', 'Analisis Data', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (7, 7, 'id', 'name', 'Data Set', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (8, 8, 'id', 'name', 'Teks Sumber', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (9, 9, 'id', 'name', 'Multimedia', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (10, 10, 'id', 'name', 'Gambar', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (11, 11, 'id', 'name', 'HTML StyleSheet', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (12, 12, 'id', 'name', 'Lainnya', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (13, 13, 'id', 'name', 'File Utama Naskah', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (14, 14, 'id', 'name', 'Instrumen Penelitian', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (15, 15, 'id', 'name', 'Bahan Penelitian', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (16, 16, 'id', 'name', 'Hasil Penelitian', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (17, 17, 'id', 'name', 'Transkrip', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (18, 18, 'id', 'name', 'Analisis Data', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (19, 19, 'id', 'name', 'Data Set', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (20, 20, 'id', 'name', 'Teks Sumber', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (21, 21, 'id', 'name', 'Multimedia', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (22, 22, 'id', 'name', 'Gambar', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (23, 23, 'id', 'name', 'HTML StyleSheet', 'string');
INSERT INTO public.genre_settings (genre_setting_id, genre_id, locale, setting_name, setting_value, setting_type) VALUES (24, 24, 'id', 'name', 'Lainnya', 'string');


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (1, 1, 0, 1, 1, 0, 0, 1, 'SUBMISSION');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (2, 1, 1, 1, 3, 0, 1, 0, 'RESEARCHINSTRUMENT');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (3, 1, 2, 1, 3, 0, 1, 0, 'RESEARCHMATERIALS');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (4, 1, 3, 1, 3, 0, 1, 0, 'RESEARCHRESULTS');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (5, 1, 4, 1, 3, 0, 1, 0, 'TRANSCRIPTS');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (6, 1, 5, 1, 3, 0, 1, 0, 'DATAANALYSIS');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (7, 1, 6, 1, 3, 0, 1, 0, 'DATASET');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (8, 1, 7, 1, 3, 0, 1, 0, 'SOURCETEXTS');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (9, 1, 8, 1, 1, 1, 1, 0, 'MULTIMEDIA');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (10, 1, 9, 1, 2, 1, 0, 0, 'IMAGE');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (11, 1, 10, 1, 1, 1, 0, 0, 'STYLE');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (12, 1, 11, 1, 3, 0, 1, 0, 'OTHER');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (13, 2, 0, 1, 1, 0, 0, 1, 'SUBMISSION');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (14, 2, 1, 1, 3, 0, 1, 0, 'RESEARCHINSTRUMENT');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (15, 2, 2, 1, 3, 0, 1, 0, 'RESEARCHMATERIALS');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (16, 2, 3, 1, 3, 0, 1, 0, 'RESEARCHRESULTS');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (17, 2, 4, 1, 3, 0, 1, 0, 'TRANSCRIPTS');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (18, 2, 5, 1, 3, 0, 1, 0, 'DATAANALYSIS');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (19, 2, 6, 1, 3, 0, 1, 0, 'DATASET');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (20, 2, 7, 1, 3, 0, 1, 0, 'SOURCETEXTS');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (21, 2, 8, 1, 1, 1, 1, 0, 'MULTIMEDIA');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (22, 2, 9, 1, 2, 1, 0, 0, 'IMAGE');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (23, 2, 10, 1, 1, 1, 0, 0, 'STYLE');
INSERT INTO public.genres (genre_id, context_id, seq, enabled, category, dependent, supplementary, required, entry_key) VALUES (24, 2, 11, 1, 3, 0, 1, 0, 'OTHER');


--
-- Data for Name: journal_settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (1, 1, 'en', 'acronym', 'bebas');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (3, 1, 'id', 'authorGuidelines', '<p>Para penulis diundang untuk mengirimkan naskahnya ke jurnal ini. Semua naskah akan dinilai oleh seorang editor untuk menentukan apakah sudah sesuai dengan tujuan dan cakupan jurnal ini. Naskah yang sesuai akan dikirimkan untuk ditinjau oleh mitra bestari sebelum menentukan apakah naskah tersebut akan diterima atau ditolak.</p><p>Sebelum mengirim, penulis bertanggung jawab untuk memperoleh izin untuk menerbitkan semua materi yang disertakan dalam naskah, seperti foto, dokumen, dan kumpulan data. Semua penulis yang tertera dalam naskah harus memberikan persetujuan untuk diakui sebagai penulis. Bila diperlukan, penelitian harus disetujui oleh suatu komite etik yang tepat sesuai dengan persyaratan hukum negara tempat penelitian.</p><p>Editor dapat menolak sebuah naskah jika tidak memenuhi standar minimum kualitas. Sebelum mengirim, pastikan bahwa desain penelitian dan argumen penelitian terstruktur dan dirumuskan dengan baik. Judul harus singkat dan abstrak harus bisa berdiri sendiri. Hal ini akan meningkatkan kemungkinan reviewer bersedia mereview naskah tersebut. Setelah sudah yakin telah memenuhi ketentuan ini, silakan tandai daftar periksa di bawah ini untuk menyiapkan naskah Anda.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (4, 1, 'id', 'authorInformation', 'Tertarik menerbitkan jurnal? Kami merekomendasikan Anda mereview halaman <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs/about">Tentang Kami </a>untuk kebijakan bagian jurnal serta <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs/about/submissions#authorGuidelines">Petunjuk Penulis </a>. Penulis perlu <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs/user/register">Mendaftar </a>dengan jurnal sebelum menyerahkan atau jika sudah terdaftar <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/index/login">login</a>dan mulai proses lima langkah.');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (5, 1, 'id', 'beginSubmissionHelp', '<p>Terima kasih telah mengirimkan naskah anda ke . Anda akan diminta untuk menggunggah file, mengidentifikasi rekan pengarang, dan menyediakan informasi seperti judul dan abstrak.<p><p>Silakan baca <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs/about/submissions" target="_blank">Panduan Pengiriman Naskah Kami</a> Jika anda belum menyelesaikannya. Saat mengisi formulir, berikan informasi sedetail mungkin untuk membantu editor kami mengevaluasi karya anda.</p><p>Saat anda mulai, anda dapat menyimpan naskah anda dan kembali kemudian. Anda dapat mereview dan mengoreksi informasi apapun sebelum anda mengirimkan naskah.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (6, 1, '', 'citations', 'request');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (7, 1, '', 'contactEmail', 'admin@example.com');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (8, 1, '', 'contactName', '123');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (9, 1, 'id', 'contributorsHelp', '<p>Tambahkan detail untuk semua kontributor dari naskah ini. Kontributor yang ditambahkan di sini akan dikirimkan email konfirmasi dari pengiriman naskah ini, juga salinan dari keputusan editorial yang dibuat terhadap naskah ini </p><p> kontributor tidak dapat dihubungi via email, karena mereka harus tetap anonim atau tidak memiliki akun email, mohon tidak memberikan alamat email palsu. Anda dapat menambahkan informasi mengenai kontributor ini di pesan kepada editor pada langkah berikutnya dari proses pengiriman naskah ini.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (10, 1, '', 'country', 'ID');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (11, 1, '', 'defaultReviewMode', '2');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (14, 1, 'id', 'detailsHelp', '<p>Mohon sediakan detail berikut untuk membantu kami mengelola naskah anda pada sistem kami.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (15, 1, '', 'copySubmissionAckPrimaryContact', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (16, 1, '', 'copySubmissionAckAddress', '');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (17, 1, '', 'emailSignature', '<br><br>—<br><p>Ini adalah pesan otomatis dari <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs"></a>.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (18, 1, '', 'enableDois', '1');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (19, 1, '', 'doiSuffixType', 'default');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (20, 1, '', 'registrationAgency', '');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (21, 1, '', 'disableSubmissions', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (22, 1, '', 'editorialStatsEmail', '1');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (23, 1, 'id', 'forTheEditorsHelp', '<p>Mohon sediakan detail berikut untuk membantu tim editorial kami mengelola naskah anda.</p><p>Ketika memasukkan metadata, sediakan entri yang menurut anda paling membantu orang yang akan mengelola naskah anda. Informasi ini dapat diubah sebelum penerbitan.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (24, 1, '', 'itemsPerPage', '25');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (25, 1, '', 'keywords', 'request');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (26, 1, 'id', 'librarianInformation', 'Kami mendorong pustakawan riset untuk mendaftar jurnal diantara pemegang jurnal eletronik perpustakaan. Begitu juga, ini mungkin berharga bahwa sistem penerbitan sumber terbuka jurnal cocok untuk perpustakaan untuk menjadi tuan rumah untuk anggota fakultas untuk menggunakan jurnal saat mereka terlibat dalam proses editing. (Kunjungi <a href="https://pkp.sfu.ca/ojs">Open Journal Systems</a>).');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (27, 1, 'en', 'name', 'bebas');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (28, 1, 'id', 'name', 'bebas');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (29, 1, '', 'notifyAllAuthors', '1');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (30, 1, '', 'numPageLinks', '10');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (31, 1, '', 'numWeeksPerResponse', '4');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (32, 1, '', 'numWeeksPerReview', '4');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (33, 1, '', 'numReviewsPerSubmission', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (34, 1, 'id', 'openAccessPolicy', 'Jurnal ini menyediakan akses terbuka yang pada prinsipnya membuat riset tersedia secara gratis untuk publik dan akan mensupport pertukaran pengetahuan global terbesar.');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (35, 1, '', 'orcidCity', '');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (36, 1, '', 'orcidClientId', '');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (37, 1, '', 'orcidClientSecret', '');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (38, 1, '', 'orcidEnabled', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (39, 1, '', 'orcidLogLevel', 'ERROR');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (40, 1, '', 'orcidSendMailToAuthorsOnPublication', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (41, 1, 'id', 'privacyStatement', '<p>Nama dan alamat email yang dimasukkan di website ini hanya akan digunakan untuk tujuan yang sudah disebutkan, tidak akan disalahgunakan untuk tujuan lain atau untuk disebarluaskan ke pihak lain.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (42, 1, 'id', 'readerInformation', 'Kami mendorong pembaca untuk mendaftarkan diri di layanan notifikasi penerbitan untuk jurnal ini. Gunakan tautan <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs/user/register">Daftar</a>di bagian atas beranda jurnal. Dengan mendaftar, pembaca akan memperoleh email berisi Daftar Isi tiap ada terbitan jurnal baru. Daftar ini juga membuat jurnal dapat mengetahui tingkat dukungan atau jumlah pembaca. Lihat jurnal <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs/about/submissions#privacyStatement">Pernyataan Privasi</a>, yang meyakinkan pembaca bahwa nama dan alamat email yang didaftarkan tidak akan digunakan untuk tujuan lain.');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (43, 1, 'id', 'reviewHelp', '<p>Review informasi yang telah anda masukkan sebelum menyelesaikan pengiriman naskah anda. Anda dapat mengubah detail yang ditampilkan di sini dengan mengklik tombol edit pada bagian atas dari setiap bagian.</p><p>Setelah anda menyelesaikan pengiriman naskah anda, anggaota dari tim editorial kami akan mereviewnya. Mohon pastikan informasi detail yang telah anda masukkan di sini seakurat mungkin.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (44, 1, '', 'submissionAcknowledgement', 'allAuthors');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (45, 1, 'id', 'submissionChecklist', '<p>Seluruh naskah harus memenuhi persyaratan berikut.</p><ul><li>Naskah ini memenuhi persyaratan yang disebutkan dalam <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs/about/submissions">Panduan bagi Penulis</a>.</li><li>Naskah ini belum perah diterbitkan, tidak pula sedang dalam pertimbangan jurnal lain.</li><li>Remua referensi telah diperiksa akurasi dan kelengkapannya.</li><li>Semua tabel dan gambat sudah diberi nomor dan judul.</li><li>Ijin telah diperoleh untuk menerbitkan semua foto, dataset dan bahan lain yang tersedia dalam naskah ini.</li></ul>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (46, 1, '', 'submitWithCategories', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (47, 1, '', 'supportedAddedSubmissionLocales', '["id"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (48, 1, '', 'supportedDefaultSubmissionLocale', 'id');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (49, 1, '', 'supportedFormLocales', '["id"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (50, 1, '', 'supportedLocales', '["id"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (51, 1, '', 'supportedSubmissionLocales', '["id"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (52, 1, '', 'supportedSubmissionMetadataLocales', '["id"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (53, 1, '', 'themePluginPath', 'default');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (54, 1, 'id', 'uploadFilesHelp', '<p>Sediakan file apapun yang mungkin dibutuhkan oleh tim editorial kamu untuk mengevaluasi naskah anda. Sebagai tambahan pada karya utama, anda dapat mengirimkan dataset, pernyataan konflik kepentikan, atau file tambahan lain jika ini berguna untuk editor kami </p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (55, 1, '', 'enableGeoUsageStats', 'disabled');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (56, 1, '', 'enableInstitutionUsageStats', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (57, 1, '', 'isSushiApiPublic', '1');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (60, 1, 'id', 'clockssLicense', 'Journal ini memakai sistem CLOCKSS untum membuat sistem pengarsipan terdistribusi di antara pustaka yang turut berpartisipasi dan mengizinkan pustaka tersebut membuat arsip jurnal secara permanen untuk tujuan pemeliharaan dan pemulihan. <a href="https://clockss.org">More...</a>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (61, 1, '', 'copyrightYearBasis', 'issue');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (62, 1, '', 'enabledDoiTypes', '["publication"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (63, 1, '', 'doiCreationTime', 'copyEditCreationTime');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (64, 1, '', 'enableOai', '1');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (65, 1, 'id', 'lockssLicense', 'OJS sistem LOCKSS berfungsi sebagai sistem pengarsipan terdistribusi antar-perpustakaan yang menggunakan sistem ini dengan tujuan membuat arsip permanen (untuk preservasi dan restorasi). <a href="https://www.lockss.org">Lanjut...</a>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (66, 1, '', 'membershipFee', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (67, 1, '', 'publicationFee', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (68, 1, '', 'purchaseArticleFee', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (69, 1, '', 'doiVersioning', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (70, 1, 'id', 'reviewerSuggestionsHelp', '<p>Saat mengirimkan naskah, anda mempunyai pilihan untuk menyarankan reviewer yang potensial. Ini dapat mempersingkat proses review dan menyediakan masukan berharga bagi tim editorial. Mohon pilih reviewer yang ahli di bidangnya dan tidak ada konflik kepentingan dengan karya anda. Fitur ini bertujuan untuk meningkatkan proses review dan mendukung pengalaman yang efisien baik untuk penulis maupun tim editorial.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (71, 2, 'en', 'acronym', 'bebas2');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (72, 2, 'id', 'acronym', NULL);
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (73, 2, 'id', 'authorGuidelines', '<p>Para penulis diundang untuk mengirimkan naskahnya ke jurnal ini. Semua naskah akan dinilai oleh seorang editor untuk menentukan apakah sudah sesuai dengan tujuan dan cakupan jurnal ini. Naskah yang sesuai akan dikirimkan untuk ditinjau oleh mitra bestari sebelum menentukan apakah naskah tersebut akan diterima atau ditolak.</p><p>Sebelum mengirim, penulis bertanggung jawab untuk memperoleh izin untuk menerbitkan semua materi yang disertakan dalam naskah, seperti foto, dokumen, dan kumpulan data. Semua penulis yang tertera dalam naskah harus memberikan persetujuan untuk diakui sebagai penulis. Bila diperlukan, penelitian harus disetujui oleh suatu komite etik yang tepat sesuai dengan persyaratan hukum negara tempat penelitian.</p><p>Editor dapat menolak sebuah naskah jika tidak memenuhi standar minimum kualitas. Sebelum mengirim, pastikan bahwa desain penelitian dan argumen penelitian terstruktur dan dirumuskan dengan baik. Judul harus singkat dan abstrak harus bisa berdiri sendiri. Hal ini akan meningkatkan kemungkinan reviewer bersedia mereview naskah tersebut. Setelah sudah yakin telah memenuhi ketentuan ini, silakan tandai daftar periksa di bawah ini untuk menyiapkan naskah Anda.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (74, 2, 'id', 'authorInformation', 'Tertarik menerbitkan jurnal? Kami merekomendasikan Anda mereview halaman <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs2/about">Tentang Kami </a>untuk kebijakan bagian jurnal serta <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs2/about/submissions#authorGuidelines">Petunjuk Penulis </a>. Penulis perlu <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs2/user/register">Mendaftar </a>dengan jurnal sebelum menyerahkan atau jika sudah terdaftar <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/index/login">login</a>dan mulai proses lima langkah.');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (75, 2, 'id', 'beginSubmissionHelp', '<p>Terima kasih telah mengirimkan naskah anda ke . Anda akan diminta untuk menggunggah file, mengidentifikasi rekan pengarang, dan menyediakan informasi seperti judul dan abstrak.<p><p>Silakan baca <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs2/about/submissions" target="_blank">Panduan Pengiriman Naskah Kami</a> Jika anda belum menyelesaikannya. Saat mengisi formulir, berikan informasi sedetail mungkin untuk membantu editor kami mengevaluasi karya anda.</p><p>Saat anda mulai, anda dapat menyimpan naskah anda dan kembali kemudian. Anda dapat mereview dan mengoreksi informasi apapun sebelum anda mengirimkan naskah.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (76, 2, '', 'citations', 'request');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (77, 2, '', 'contactEmail', 'admin@example.com');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (78, 2, '', 'contactName', '123');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (79, 2, 'id', 'contributorsHelp', '<p>Tambahkan detail untuk semua kontributor dari naskah ini. Kontributor yang ditambahkan di sini akan dikirimkan email konfirmasi dari pengiriman naskah ini, juga salinan dari keputusan editorial yang dibuat terhadap naskah ini </p><p> kontributor tidak dapat dihubungi via email, karena mereka harus tetap anonim atau tidak memiliki akun email, mohon tidak memberikan alamat email palsu. Anda dapat menambahkan informasi mengenai kontributor ini di pesan kepada editor pada langkah berikutnya dari proses pengiriman naskah ini.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (80, 2, '', 'country', 'ID');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (81, 2, '', 'defaultReviewMode', '2');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (84, 2, 'id', 'detailsHelp', '<p>Mohon sediakan detail berikut untuk membantu kami mengelola naskah anda pada sistem kami.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (85, 2, '', 'copySubmissionAckPrimaryContact', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (86, 2, '', 'copySubmissionAckAddress', '');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (87, 2, '', 'emailSignature', '<br><br>—<br><p>Ini adalah pesan otomatis dari <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs2"></a>.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (88, 2, '', 'enableDois', '1');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (89, 2, '', 'doiSuffixType', 'default');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (90, 2, '', 'registrationAgency', '');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (91, 2, '', 'disableSubmissions', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (92, 2, '', 'editorialStatsEmail', '1');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (93, 2, 'id', 'forTheEditorsHelp', '<p>Mohon sediakan detail berikut untuk membantu tim editorial kami mengelola naskah anda.</p><p>Ketika memasukkan metadata, sediakan entri yang menurut anda paling membantu orang yang akan mengelola naskah anda. Informasi ini dapat diubah sebelum penerbitan.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (94, 2, '', 'itemsPerPage', '25');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (95, 2, '', 'keywords', 'request');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (96, 2, 'id', 'librarianInformation', 'Kami mendorong pustakawan riset untuk mendaftar jurnal diantara pemegang jurnal eletronik perpustakaan. Begitu juga, ini mungkin berharga bahwa sistem penerbitan sumber terbuka jurnal cocok untuk perpustakaan untuk menjadi tuan rumah untuk anggota fakultas untuk menggunakan jurnal saat mereka terlibat dalam proses editing. (Kunjungi <a href="https://pkp.sfu.ca/ojs">Open Journal Systems</a>).');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (97, 2, 'en', 'name', 'bebas2');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (98, 2, 'id', 'name', NULL);
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (99, 2, '', 'notifyAllAuthors', '1');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (100, 2, '', 'numPageLinks', '10');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (101, 2, '', 'numWeeksPerResponse', '4');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (102, 2, '', 'numWeeksPerReview', '4');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (103, 2, '', 'numReviewsPerSubmission', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (104, 2, 'id', 'openAccessPolicy', 'Jurnal ini menyediakan akses terbuka yang pada prinsipnya membuat riset tersedia secara gratis untuk publik dan akan mensupport pertukaran pengetahuan global terbesar.');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (105, 2, '', 'orcidCity', '');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (106, 2, '', 'orcidClientId', '');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (107, 2, '', 'orcidClientSecret', '');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (108, 2, '', 'orcidEnabled', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (109, 2, '', 'orcidLogLevel', 'ERROR');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (110, 2, '', 'orcidSendMailToAuthorsOnPublication', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (111, 2, 'id', 'privacyStatement', '<p>Nama dan alamat email yang dimasukkan di website ini hanya akan digunakan untuk tujuan yang sudah disebutkan, tidak akan disalahgunakan untuk tujuan lain atau untuk disebarluaskan ke pihak lain.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (112, 2, 'id', 'readerInformation', 'Kami mendorong pembaca untuk mendaftarkan diri di layanan notifikasi penerbitan untuk jurnal ini. Gunakan tautan <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs2/user/register">Daftar</a>di bagian atas beranda jurnal. Dengan mendaftar, pembaca akan memperoleh email berisi Daftar Isi tiap ada terbitan jurnal baru. Daftar ini juga membuat jurnal dapat mengetahui tingkat dukungan atau jumlah pembaca. Lihat jurnal <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs2/about/submissions#privacyStatement">Pernyataan Privasi</a>, yang meyakinkan pembaca bahwa nama dan alamat email yang didaftarkan tidak akan digunakan untuk tujuan lain.');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (113, 2, 'id', 'reviewHelp', '<p>Review informasi yang telah anda masukkan sebelum menyelesaikan pengiriman naskah anda. Anda dapat mengubah detail yang ditampilkan di sini dengan mengklik tombol edit pada bagian atas dari setiap bagian.</p><p>Setelah anda menyelesaikan pengiriman naskah anda, anggaota dari tim editorial kami akan mereviewnya. Mohon pastikan informasi detail yang telah anda masukkan di sini seakurat mungkin.</p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (114, 2, '', 'submissionAcknowledgement', 'allAuthors');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (115, 2, 'id', 'submissionChecklist', '<p>Seluruh naskah harus memenuhi persyaratan berikut.</p><ul><li>Naskah ini memenuhi persyaratan yang disebutkan dalam <a href="http://localhost/ojs/ojs-3.5.0-5/index.php/ojs2/about/submissions">Panduan bagi Penulis</a>.</li><li>Naskah ini belum perah diterbitkan, tidak pula sedang dalam pertimbangan jurnal lain.</li><li>Remua referensi telah diperiksa akurasi dan kelengkapannya.</li><li>Semua tabel dan gambat sudah diberi nomor dan judul.</li><li>Ijin telah diperoleh untuk menerbitkan semua foto, dataset dan bahan lain yang tersedia dalam naskah ini.</li></ul>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (116, 2, '', 'submitWithCategories', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (117, 2, '', 'supportedAddedSubmissionLocales', '["id"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (118, 2, '', 'supportedDefaultSubmissionLocale', 'id');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (119, 2, '', 'supportedFormLocales', '["id"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (120, 2, '', 'supportedLocales', '["id"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (121, 2, '', 'supportedSubmissionLocales', '["id"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (122, 2, '', 'supportedSubmissionMetadataLocales', '["id"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (123, 2, '', 'themePluginPath', 'default');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (124, 2, 'id', 'uploadFilesHelp', '<p>Sediakan file apapun yang mungkin dibutuhkan oleh tim editorial kamu untuk mengevaluasi naskah anda. Sebagai tambahan pada karya utama, anda dapat mengirimkan dataset, pernyataan konflik kepentikan, atau file tambahan lain jika ini berguna untuk editor kami </p>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (125, 2, '', 'enableGeoUsageStats', 'disabled');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (126, 2, '', 'enableInstitutionUsageStats', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (127, 2, '', 'isSushiApiPublic', '1');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (130, 2, 'id', 'clockssLicense', 'Journal ini memakai sistem CLOCKSS untum membuat sistem pengarsipan terdistribusi di antara pustaka yang turut berpartisipasi dan mengizinkan pustaka tersebut membuat arsip jurnal secara permanen untuk tujuan pemeliharaan dan pemulihan. <a href="https://clockss.org">More...</a>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (131, 2, '', 'copyrightYearBasis', 'issue');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (132, 2, '', 'enabledDoiTypes', '["publication"]');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (133, 2, '', 'doiCreationTime', 'copyEditCreationTime');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (134, 2, '', 'enableOai', '1');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (135, 2, 'id', 'lockssLicense', 'OJS sistem LOCKSS berfungsi sebagai sistem pengarsipan terdistribusi antar-perpustakaan yang menggunakan sistem ini dengan tujuan membuat arsip permanen (untuk preservasi dan restorasi). <a href="https://www.lockss.org">Lanjut...</a>');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (136, 2, '', 'membershipFee', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (137, 2, '', 'publicationFee', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (138, 2, '', 'purchaseArticleFee', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (139, 2, '', 'doiVersioning', '0');
INSERT INTO public.journal_settings (journal_setting_id, journal_id, locale, setting_name, setting_value) VALUES (140, 2, 'id', 'reviewerSuggestionsHelp', '<p>Saat mengirimkan naskah, anda mempunyai pilihan untuk menyarankan reviewer yang potensial. Ini dapat mempersingkat proses review dan menyediakan masukan berharga bagi tim editorial. Mohon pilih reviewer yang ahli di bidangnya dan tidak ada konflik kepentingan dengan karya anda. Fitur ini bertujuan untuk meningkatkan proses review dan mendukung pengalaman yang efisien baik untuk penulis maupun tim editorial.</p>');


--
-- Data for Name: journals; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.journals (journal_id, path, seq, primary_locale, enabled, current_issue_id) VALUES (1, 'ojs', 1, 'id', 1, 1);
INSERT INTO public.journals (journal_id, path, seq, primary_locale, enabled, current_issue_id) VALUES (2, 'ojs2', 2, 'id', 1, NULL);


--
-- Data for Name: navigation_menu_item_assignments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (1, 1, 1, NULL, 0);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (2, 1, 2, NULL, 1);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (3, 1, 3, NULL, 2);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (4, 1, 4, 3, 0);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (5, 1, 5, 3, 1);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (6, 1, 6, 3, 2);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (7, 1, 7, 3, 3);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (8, 2, 8, NULL, 0);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (9, 2, 9, NULL, 1);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (10, 2, 10, NULL, 2);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (11, 2, 11, 10, 0);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (12, 2, 12, 10, 1);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (13, 2, 13, 10, 2);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (14, 2, 14, 10, 3);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (15, 3, 15, NULL, 0);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (16, 3, 16, NULL, 1);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (17, 3, 17, NULL, 2);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (18, 3, 18, NULL, 3);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (19, 3, 19, 18, 0);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (20, 3, 20, 18, 1);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (21, 3, 21, 18, 2);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (22, 3, 22, 18, 3);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (23, 3, 23, 18, 4);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (24, 4, 25, NULL, 0);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (25, 4, 26, NULL, 1);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (26, 4, 27, NULL, 2);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (27, 4, 28, 27, 0);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (28, 4, 29, 27, 1);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (29, 4, 30, 27, 2);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (30, 4, 31, 27, 3);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (31, 5, 32, NULL, 0);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (32, 5, 33, NULL, 1);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (33, 5, 34, NULL, 2);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (34, 5, 35, NULL, 3);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (35, 5, 36, 35, 0);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (36, 5, 37, 35, 1);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (37, 5, 38, 35, 2);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (38, 5, 39, 35, 3);
INSERT INTO public.navigation_menu_item_assignments (navigation_menu_item_assignment_id, navigation_menu_id, navigation_menu_item_id, parent_id, seq) VALUES (39, 5, 40, 35, 4);


--
-- Data for Name: navigation_menu_item_settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (1, 1, '', 'titleLocaleKey', 'navigation.register', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (2, 2, '', 'titleLocaleKey', 'navigation.login', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (3, 3, '', 'titleLocaleKey', '{$loggedInUsername}', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (4, 4, '', 'titleLocaleKey', 'navigation.dashboard', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (5, 5, '', 'titleLocaleKey', 'common.viewProfile', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (6, 6, '', 'titleLocaleKey', 'navigation.admin', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (7, 7, '', 'titleLocaleKey', 'user.logOut', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (8, 8, '', 'titleLocaleKey', 'navigation.register', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (9, 9, '', 'titleLocaleKey', 'navigation.login', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (10, 10, '', 'titleLocaleKey', '{$loggedInUsername}', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (11, 11, '', 'titleLocaleKey', 'navigation.dashboard', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (12, 12, '', 'titleLocaleKey', 'common.viewProfile', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (13, 13, '', 'titleLocaleKey', 'navigation.admin', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (14, 14, '', 'titleLocaleKey', 'user.logOut', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (15, 15, '', 'titleLocaleKey', 'navigation.current', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (16, 16, '', 'titleLocaleKey', 'navigation.archives', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (17, 17, '', 'titleLocaleKey', 'manager.announcements', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (18, 18, '', 'titleLocaleKey', 'navigation.about', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (19, 19, '', 'titleLocaleKey', 'about.aboutContext', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (20, 20, '', 'titleLocaleKey', 'about.submissions', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (21, 21, '', 'titleLocaleKey', 'common.editorialMasthead', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (22, 22, '', 'titleLocaleKey', 'manager.setup.privacyStatement', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (23, 23, '', 'titleLocaleKey', 'about.contact', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (24, 24, '', 'titleLocaleKey', 'common.search', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (25, 25, '', 'titleLocaleKey', 'navigation.register', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (26, 26, '', 'titleLocaleKey', 'navigation.login', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (27, 27, '', 'titleLocaleKey', '{$loggedInUsername}', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (28, 28, '', 'titleLocaleKey', 'navigation.dashboard', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (29, 29, '', 'titleLocaleKey', 'common.viewProfile', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (30, 30, '', 'titleLocaleKey', 'navigation.admin', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (31, 31, '', 'titleLocaleKey', 'user.logOut', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (32, 32, '', 'titleLocaleKey', 'navigation.current', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (33, 33, '', 'titleLocaleKey', 'navigation.archives', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (34, 34, '', 'titleLocaleKey', 'manager.announcements', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (35, 35, '', 'titleLocaleKey', 'navigation.about', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (36, 36, '', 'titleLocaleKey', 'about.aboutContext', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (37, 37, '', 'titleLocaleKey', 'about.submissions', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (38, 38, '', 'titleLocaleKey', 'common.editorialMasthead', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (39, 39, '', 'titleLocaleKey', 'manager.setup.privacyStatement', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (40, 40, '', 'titleLocaleKey', 'about.contact', 'string');
INSERT INTO public.navigation_menu_item_settings (navigation_menu_item_setting_id, navigation_menu_item_id, locale, setting_name, setting_value, setting_type) VALUES (41, 41, '', 'titleLocaleKey', 'common.search', 'string');


--
-- Data for Name: navigation_menu_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (1, NULL, NULL, 'NMI_TYPE_USER_REGISTER');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (2, NULL, NULL, 'NMI_TYPE_USER_LOGIN');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (3, NULL, NULL, 'NMI_TYPE_USER_DASHBOARD');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (4, NULL, NULL, 'NMI_TYPE_USER_DASHBOARD');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (5, NULL, NULL, 'NMI_TYPE_USER_PROFILE');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (6, NULL, NULL, 'NMI_TYPE_ADMINISTRATION');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (7, NULL, NULL, 'NMI_TYPE_USER_LOGOUT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (8, 1, NULL, 'NMI_TYPE_USER_REGISTER');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (9, 1, NULL, 'NMI_TYPE_USER_LOGIN');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (10, 1, NULL, 'NMI_TYPE_USER_DASHBOARD');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (11, 1, NULL, 'NMI_TYPE_USER_DASHBOARD');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (12, 1, NULL, 'NMI_TYPE_USER_PROFILE');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (13, 1, NULL, 'NMI_TYPE_ADMINISTRATION');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (14, 1, NULL, 'NMI_TYPE_USER_LOGOUT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (15, 1, NULL, 'NMI_TYPE_CURRENT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (16, 1, NULL, 'NMI_TYPE_ARCHIVES');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (17, 1, NULL, 'NMI_TYPE_ANNOUNCEMENTS');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (18, 1, NULL, 'NMI_TYPE_ABOUT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (19, 1, NULL, 'NMI_TYPE_ABOUT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (20, 1, NULL, 'NMI_TYPE_SUBMISSIONS');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (21, 1, NULL, 'NMI_TYPE_MASTHEAD');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (22, 1, NULL, 'NMI_TYPE_PRIVACY');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (23, 1, NULL, 'NMI_TYPE_CONTACT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (24, 1, NULL, 'NMI_TYPE_SEARCH');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (25, 2, NULL, 'NMI_TYPE_USER_REGISTER');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (26, 2, NULL, 'NMI_TYPE_USER_LOGIN');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (27, 2, NULL, 'NMI_TYPE_USER_DASHBOARD');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (28, 2, NULL, 'NMI_TYPE_USER_DASHBOARD');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (29, 2, NULL, 'NMI_TYPE_USER_PROFILE');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (30, 2, NULL, 'NMI_TYPE_ADMINISTRATION');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (31, 2, NULL, 'NMI_TYPE_USER_LOGOUT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (32, 2, NULL, 'NMI_TYPE_CURRENT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (33, 2, NULL, 'NMI_TYPE_ARCHIVES');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (34, 2, NULL, 'NMI_TYPE_ANNOUNCEMENTS');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (35, 2, NULL, 'NMI_TYPE_ABOUT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (36, 2, NULL, 'NMI_TYPE_ABOUT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (37, 2, NULL, 'NMI_TYPE_SUBMISSIONS');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (38, 2, NULL, 'NMI_TYPE_MASTHEAD');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (39, 2, NULL, 'NMI_TYPE_PRIVACY');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (40, 2, NULL, 'NMI_TYPE_CONTACT');
INSERT INTO public.navigation_menu_items (navigation_menu_item_id, context_id, path, type) VALUES (41, 2, NULL, 'NMI_TYPE_SEARCH');


--
-- Data for Name: navigation_menus; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.navigation_menus (navigation_menu_id, context_id, area_name, title) VALUES (1, NULL, 'user', 'User Navigation Menu');
INSERT INTO public.navigation_menus (navigation_menu_id, context_id, area_name, title) VALUES (2, 1, 'user', 'User Navigation Menu');
INSERT INTO public.navigation_menus (navigation_menu_id, context_id, area_name, title) VALUES (3, 1, 'primary', 'Primary Navigation Menu');
INSERT INTO public.navigation_menus (navigation_menu_id, context_id, area_name, title) VALUES (4, 2, 'user', 'User Navigation Menu');
INSERT INTO public.navigation_menus (navigation_menu_id, context_id, area_name, title) VALUES (5, 2, 'primary', 'Primary Navigation Menu');


--
-- Data for Name: plugin_settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (1, 'defaultthemeplugin', NULL, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (2, 'tinymceplugin', NULL, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (3, 'usageeventplugin', NULL, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (4, 'developedbyblockplugin', NULL, 'enabled', '0', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (5, 'developedbyblockplugin', NULL, 'seq', '0', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (6, 'languagetoggleblockplugin', NULL, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (7, 'languagetoggleblockplugin', NULL, 'seq', '4', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (8, 'defaultthemeplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (9, 'tinymceplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (10, 'developedbyblockplugin', 1, 'enabled', '0', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (11, 'developedbyblockplugin', 1, 'seq', '0', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (12, 'informationblockplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (13, 'informationblockplugin', 1, 'seq', '7', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (14, 'languagetoggleblockplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (15, 'languagetoggleblockplugin', 1, 'seq', '4', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (16, 'subscriptionblockplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (17, 'subscriptionblockplugin', 1, 'seq', '2', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (18, 'dublincoremetaplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (19, 'googlescholarplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (20, 'htmlarticlegalleyplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (21, 'jatstemplateplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (22, 'lensgalleyplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (23, 'pdfjsviewerplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (24, 'webfeedplugin', 1, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (25, 'webfeedplugin', 1, 'displayPage', 'homepage', 'string');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (26, 'webfeedplugin', 1, 'displayItems', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (27, 'webfeedplugin', 1, 'recentItems', '30', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (28, 'webfeedplugin', 1, 'includeIdentifiers', '0', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (29, 'defaultthemeplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (30, 'tinymceplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (31, 'developedbyblockplugin', 2, 'enabled', '0', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (32, 'developedbyblockplugin', 2, 'seq', '0', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (33, 'informationblockplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (34, 'informationblockplugin', 2, 'seq', '7', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (35, 'languagetoggleblockplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (36, 'languagetoggleblockplugin', 2, 'seq', '4', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (37, 'subscriptionblockplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (38, 'subscriptionblockplugin', 2, 'seq', '2', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (39, 'dublincoremetaplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (40, 'googlescholarplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (41, 'htmlarticlegalleyplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (42, 'jatstemplateplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (43, 'lensgalleyplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (44, 'pdfjsviewerplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (45, 'webfeedplugin', 2, 'enabled', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (46, 'webfeedplugin', 2, 'displayPage', 'homepage', 'string');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (47, 'webfeedplugin', 2, 'displayItems', '1', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (48, 'webfeedplugin', 2, 'recentItems', '30', 'int');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (49, 'webfeedplugin', 2, 'includeIdentifiers', '0', 'bool');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (50, 'defaultthemeplugin', 1, 'typography', 'notoSans', 'string');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (51, 'defaultthemeplugin', 1, 'baseColour', '#FAC0F9', 'string');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (52, 'defaultthemeplugin', 1, 'showDescriptionInJournalIndex', 'false', 'string');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (53, 'defaultthemeplugin', 1, 'useHomepageImageAsHeader', 'false', 'string');
INSERT INTO public.plugin_settings (plugin_setting_id, plugin_name, context_id, setting_name, setting_value, setting_type) VALUES (54, 'defaultthemeplugin', 1, 'displayStats', 'none', 'string');


--
-- Data for Name: section_settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.section_settings (section_setting_id, section_id, locale, setting_name, setting_value) VALUES (1, 1, 'id', 'title', 'Articles');
INSERT INTO public.section_settings (section_setting_id, section_id, locale, setting_name, setting_value) VALUES (2, 1, 'id', 'abbrev', 'ART');
INSERT INTO public.section_settings (section_setting_id, section_id, locale, setting_name, setting_value) VALUES (3, 1, 'id', 'policy', 'Section default policy');
INSERT INTO public.section_settings (section_setting_id, section_id, locale, setting_name, setting_value) VALUES (4, 2, 'id', 'title', 'Articles');
INSERT INTO public.section_settings (section_setting_id, section_id, locale, setting_name, setting_value) VALUES (5, 2, 'id', 'abbrev', 'ART');
INSERT INTO public.section_settings (section_setting_id, section_id, locale, setting_name, setting_value) VALUES (6, 2, 'id', 'policy', 'Section default policy');


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sections (section_id, journal_id, review_form_id, seq, editor_restricted, meta_indexed, meta_reviewed, abstracts_not_required, hide_title, hide_author, is_inactive, abstract_word_count) VALUES (1, 1, NULL, 0, 0, 1, 1, 0, 0, 0, 0, NULL);
INSERT INTO public.sections (section_id, journal_id, review_form_id, seq, editor_restricted, meta_indexed, meta_reviewed, abstracts_not_required, hide_title, hide_author, is_inactive, abstract_word_count) VALUES (2, 2, NULL, 0, 0, 1, 1, 0, 0, 0, 0, NULL);


--
-- Data for Name: site; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.site (site_id, redirect_context_id, primary_locale, min_password_length, installed_locales, supported_locales, original_style_file_name) VALUES (1, NULL, 'en', 6, '["en","id"]', '["en","id"]', NULL);


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (1, 'contactEmail', 'en', 'admin@example.com');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (2, 'contactName', 'en', 'Open Journal Systems');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (3, 'contactName', 'id', 'Open Journal Systems');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (4, 'compressStatsLogs', '', '0');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (5, 'enableGeoUsageStats', '', 'disabled');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (6, 'enableInstitutionUsageStats', '', '0');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (7, 'keepDailyUsageStats', '', '0');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (8, 'isSiteSushiPlatform', '', '0');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (9, 'isSushiApiPublic', '', '1');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (10, 'disableSharedReviewerStatistics', '', '0');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (11, 'orcidClientId', '', '');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (12, 'orcidClientSecret', '', '');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (13, 'orcidEnabled', '', '0');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (14, 'themePluginPath', '', 'default');
INSERT INTO public.site_settings (site_setting_id, setting_name, locale, setting_value) VALUES (15, 'uniqueSiteId', '', '4CAF8BCB-EE37-478A-8658-42C1E9469C02');


--
-- Data for Name: user_group_settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (1, 2, '', 'nameLocaleKey', 'default.groups.name.manager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (2, 2, '', 'abbrevLocaleKey', 'default.groups.abbrev.manager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (3, 2, 'en', 'name', 'Journal manager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (4, 2, 'en', 'abbrev', 'JM');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (5, 2, 'id', 'name', 'Manajer Jurnal');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (6, 2, 'id', 'abbrev', 'JM');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (7, 3, '', 'nameLocaleKey', 'default.groups.name.editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (8, 3, '', 'abbrevLocaleKey', 'default.groups.abbrev.editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (9, 3, 'en', 'name', 'Journal editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (10, 3, 'en', 'abbrev', 'JE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (11, 3, 'id', 'name', 'Editor Jurnal');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (12, 3, 'id', 'abbrev', 'JE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (13, 4, '', 'nameLocaleKey', 'default.groups.name.productionEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (14, 4, '', 'abbrevLocaleKey', 'default.groups.abbrev.productionEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (15, 4, 'en', 'name', 'Production editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (16, 4, 'en', 'abbrev', 'ProdE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (17, 4, 'id', 'name', 'Editor produksi');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (18, 4, 'id', 'abbrev', 'ProdE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (19, 5, '', 'nameLocaleKey', 'default.groups.name.sectionEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (20, 5, '', 'abbrevLocaleKey', 'default.groups.abbrev.sectionEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (21, 5, 'en', 'name', 'Section editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (22, 5, 'en', 'abbrev', 'SecE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (23, 5, 'id', 'name', 'Editor Bagian');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (24, 5, 'id', 'abbrev', 'EdBag');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (25, 6, '', 'nameLocaleKey', 'default.groups.name.guestEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (26, 6, '', 'abbrevLocaleKey', 'default.groups.abbrev.guestEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (27, 6, 'en', 'name', 'Guest editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (28, 6, 'en', 'abbrev', 'GE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (29, 6, 'id', 'name', 'Editor Tamu');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (30, 6, 'id', 'abbrev', 'GE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (31, 7, '', 'nameLocaleKey', 'default.groups.name.copyeditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (32, 7, '', 'abbrevLocaleKey', 'default.groups.abbrev.copyeditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (33, 7, 'en', 'name', 'Copyeditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (34, 7, 'en', 'abbrev', 'CE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (35, 7, 'id', 'name', 'Copyeditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (36, 7, 'id', 'abbrev', 'CE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (37, 8, '', 'nameLocaleKey', 'default.groups.name.designer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (38, 8, '', 'abbrevLocaleKey', 'default.groups.abbrev.designer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (39, 8, 'en', 'name', 'Designer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (40, 8, 'en', 'abbrev', 'Design');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (41, 8, 'id', 'name', 'Desainer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (42, 8, 'id', 'abbrev', 'Desain');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (43, 9, '', 'nameLocaleKey', 'default.groups.name.funding');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (44, 9, '', 'abbrevLocaleKey', 'default.groups.abbrev.funding');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (45, 9, 'en', 'name', 'Funding coordinator');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (46, 9, 'en', 'abbrev', 'FC');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (47, 9, 'id', 'name', 'Koordinator pendanaan');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (48, 9, 'id', 'abbrev', 'FC');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (49, 10, '', 'nameLocaleKey', 'default.groups.name.indexer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (50, 10, '', 'abbrevLocaleKey', 'default.groups.abbrev.indexer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (51, 10, 'en', 'name', 'Indexer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (52, 10, 'en', 'abbrev', 'IND');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (53, 10, 'id', 'name', 'Pengindeks');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (54, 10, 'id', 'abbrev', 'IND');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (55, 11, '', 'nameLocaleKey', 'default.groups.name.layoutEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (56, 11, '', 'abbrevLocaleKey', 'default.groups.abbrev.layoutEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (57, 11, 'en', 'name', 'Layout Editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (58, 11, 'en', 'abbrev', 'LE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (59, 11, 'id', 'name', 'Editor Tata Letak');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (60, 11, 'id', 'abbrev', 'LE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (61, 12, '', 'nameLocaleKey', 'default.groups.name.marketing');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (62, 12, '', 'abbrevLocaleKey', 'default.groups.abbrev.marketing');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (63, 12, 'en', 'name', 'Marketing and sales coordinator');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (64, 12, 'en', 'abbrev', 'MS');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (65, 12, 'id', 'name', 'Koordinator penjualan dan pemasaran');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (66, 12, 'id', 'abbrev', 'MS');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (67, 13, '', 'nameLocaleKey', 'default.groups.name.proofreader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (68, 13, '', 'abbrevLocaleKey', 'default.groups.abbrev.proofreader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (69, 13, 'en', 'name', 'Proofreader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (70, 13, 'en', 'abbrev', 'PR');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (71, 13, 'id', 'name', 'Proofreader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (72, 13, 'id', 'abbrev', 'PR');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (73, 14, '', 'nameLocaleKey', 'default.groups.name.author');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (74, 14, '', 'abbrevLocaleKey', 'default.groups.abbrev.author');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (75, 14, 'en', 'name', 'Author');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (76, 14, 'en', 'abbrev', 'AU');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (77, 14, 'id', 'name', 'Penulis');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (78, 14, 'id', 'abbrev', 'AU');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (79, 15, '', 'nameLocaleKey', 'default.groups.name.translator');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (80, 15, '', 'abbrevLocaleKey', 'default.groups.abbrev.translator');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (81, 15, 'en', 'name', 'Translator');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (82, 15, 'en', 'abbrev', 'Trans');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (83, 15, 'id', 'name', 'Penerjemah');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (84, 15, 'id', 'abbrev', 'Trans');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (85, 16, '', 'nameLocaleKey', 'default.groups.name.externalReviewer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (86, 16, '', 'abbrevLocaleKey', 'default.groups.abbrev.externalReviewer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (87, 16, 'en', 'name', 'Reviewer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (88, 16, 'en', 'abbrev', 'R');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (89, 16, 'id', 'name', 'Mitra Bestari');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (90, 16, 'id', 'abbrev', 'R');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (91, 17, '', 'nameLocaleKey', 'default.groups.name.reader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (92, 17, '', 'abbrevLocaleKey', 'default.groups.abbrev.reader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (93, 17, 'en', 'name', 'Reader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (94, 17, 'en', 'abbrev', 'Read');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (95, 17, 'id', 'name', 'Pembaca');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (96, 17, 'id', 'abbrev', 'Baca');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (97, 18, '', 'nameLocaleKey', 'default.groups.name.subscriptionManager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (98, 18, '', 'abbrevLocaleKey', 'default.groups.abbrev.subscriptionManager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (99, 18, 'en', 'name', 'Subscription Manager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (100, 18, 'en', 'abbrev', 'SubM');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (101, 18, 'id', 'name', 'Manajer Langganan');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (102, 18, 'id', 'abbrev', 'MReg');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (103, 19, '', 'nameLocaleKey', 'default.groups.name.editorialBoardMember');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (104, 19, '', 'abbrevLocaleKey', 'default.groups.abbrev.editorialBoardMember');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (105, 19, 'en', 'name', 'Editorial Board Member');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (106, 19, 'en', 'abbrev', 'EBM');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (107, 19, 'id', 'name', 'Anggota Dewan Editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (108, 19, 'id', 'abbrev', 'EBM');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (109, 20, '', 'nameLocaleKey', 'default.groups.name.manager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (110, 20, '', 'abbrevLocaleKey', 'default.groups.abbrev.manager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (111, 20, 'en', 'name', 'Journal manager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (112, 20, 'en', 'abbrev', 'JM');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (113, 20, 'id', 'name', 'Manajer Jurnal');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (114, 20, 'id', 'abbrev', 'JM');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (115, 21, '', 'nameLocaleKey', 'default.groups.name.editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (116, 21, '', 'abbrevLocaleKey', 'default.groups.abbrev.editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (117, 21, 'en', 'name', 'Journal editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (118, 21, 'en', 'abbrev', 'JE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (119, 21, 'id', 'name', 'Editor Jurnal');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (120, 21, 'id', 'abbrev', 'JE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (121, 22, '', 'nameLocaleKey', 'default.groups.name.productionEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (122, 22, '', 'abbrevLocaleKey', 'default.groups.abbrev.productionEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (123, 22, 'en', 'name', 'Production editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (124, 22, 'en', 'abbrev', 'ProdE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (125, 22, 'id', 'name', 'Editor produksi');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (126, 22, 'id', 'abbrev', 'ProdE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (127, 23, '', 'nameLocaleKey', 'default.groups.name.sectionEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (128, 23, '', 'abbrevLocaleKey', 'default.groups.abbrev.sectionEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (129, 23, 'en', 'name', 'Section editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (130, 23, 'en', 'abbrev', 'SecE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (131, 23, 'id', 'name', 'Editor Bagian');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (132, 23, 'id', 'abbrev', 'EdBag');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (133, 24, '', 'nameLocaleKey', 'default.groups.name.guestEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (134, 24, '', 'abbrevLocaleKey', 'default.groups.abbrev.guestEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (135, 24, 'en', 'name', 'Guest editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (136, 24, 'en', 'abbrev', 'GE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (137, 24, 'id', 'name', 'Editor Tamu');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (138, 24, 'id', 'abbrev', 'GE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (139, 25, '', 'nameLocaleKey', 'default.groups.name.copyeditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (140, 25, '', 'abbrevLocaleKey', 'default.groups.abbrev.copyeditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (141, 25, 'en', 'name', 'Copyeditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (142, 25, 'en', 'abbrev', 'CE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (143, 25, 'id', 'name', 'Copyeditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (144, 25, 'id', 'abbrev', 'CE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (145, 26, '', 'nameLocaleKey', 'default.groups.name.designer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (146, 26, '', 'abbrevLocaleKey', 'default.groups.abbrev.designer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (147, 26, 'en', 'name', 'Designer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (148, 26, 'en', 'abbrev', 'Design');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (149, 26, 'id', 'name', 'Desainer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (150, 26, 'id', 'abbrev', 'Desain');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (151, 27, '', 'nameLocaleKey', 'default.groups.name.funding');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (152, 27, '', 'abbrevLocaleKey', 'default.groups.abbrev.funding');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (153, 27, 'en', 'name', 'Funding coordinator');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (154, 27, 'en', 'abbrev', 'FC');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (155, 27, 'id', 'name', 'Koordinator pendanaan');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (156, 27, 'id', 'abbrev', 'FC');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (157, 28, '', 'nameLocaleKey', 'default.groups.name.indexer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (158, 28, '', 'abbrevLocaleKey', 'default.groups.abbrev.indexer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (159, 28, 'en', 'name', 'Indexer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (160, 28, 'en', 'abbrev', 'IND');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (161, 28, 'id', 'name', 'Pengindeks');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (162, 28, 'id', 'abbrev', 'IND');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (163, 29, '', 'nameLocaleKey', 'default.groups.name.layoutEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (164, 29, '', 'abbrevLocaleKey', 'default.groups.abbrev.layoutEditor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (165, 29, 'en', 'name', 'Layout Editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (166, 29, 'en', 'abbrev', 'LE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (167, 29, 'id', 'name', 'Editor Tata Letak');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (168, 29, 'id', 'abbrev', 'LE');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (169, 30, '', 'nameLocaleKey', 'default.groups.name.marketing');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (170, 30, '', 'abbrevLocaleKey', 'default.groups.abbrev.marketing');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (171, 30, 'en', 'name', 'Marketing and sales coordinator');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (172, 30, 'en', 'abbrev', 'MS');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (173, 30, 'id', 'name', 'Koordinator penjualan dan pemasaran');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (174, 30, 'id', 'abbrev', 'MS');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (175, 31, '', 'nameLocaleKey', 'default.groups.name.proofreader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (176, 31, '', 'abbrevLocaleKey', 'default.groups.abbrev.proofreader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (177, 31, 'en', 'name', 'Proofreader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (178, 31, 'en', 'abbrev', 'PR');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (179, 31, 'id', 'name', 'Proofreader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (180, 31, 'id', 'abbrev', 'PR');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (181, 32, '', 'nameLocaleKey', 'default.groups.name.author');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (182, 32, '', 'abbrevLocaleKey', 'default.groups.abbrev.author');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (183, 32, 'en', 'name', 'Author');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (184, 32, 'en', 'abbrev', 'AU');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (185, 32, 'id', 'name', 'Penulis');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (186, 32, 'id', 'abbrev', 'AU');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (187, 33, '', 'nameLocaleKey', 'default.groups.name.translator');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (188, 33, '', 'abbrevLocaleKey', 'default.groups.abbrev.translator');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (189, 33, 'en', 'name', 'Translator');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (190, 33, 'en', 'abbrev', 'Trans');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (191, 33, 'id', 'name', 'Penerjemah');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (192, 33, 'id', 'abbrev', 'Trans');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (193, 34, '', 'nameLocaleKey', 'default.groups.name.externalReviewer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (194, 34, '', 'abbrevLocaleKey', 'default.groups.abbrev.externalReviewer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (195, 34, 'en', 'name', 'Reviewer');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (196, 34, 'en', 'abbrev', 'R');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (197, 34, 'id', 'name', 'Mitra Bestari');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (198, 34, 'id', 'abbrev', 'R');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (199, 35, '', 'nameLocaleKey', 'default.groups.name.reader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (200, 35, '', 'abbrevLocaleKey', 'default.groups.abbrev.reader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (201, 35, 'en', 'name', 'Reader');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (202, 35, 'en', 'abbrev', 'Read');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (203, 35, 'id', 'name', 'Pembaca');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (204, 35, 'id', 'abbrev', 'Baca');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (205, 36, '', 'nameLocaleKey', 'default.groups.name.subscriptionManager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (206, 36, '', 'abbrevLocaleKey', 'default.groups.abbrev.subscriptionManager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (207, 36, 'en', 'name', 'Subscription Manager');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (208, 36, 'en', 'abbrev', 'SubM');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (209, 36, 'id', 'name', 'Manajer Langganan');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (210, 36, 'id', 'abbrev', 'MReg');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (211, 37, '', 'nameLocaleKey', 'default.groups.name.editorialBoardMember');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (212, 37, '', 'abbrevLocaleKey', 'default.groups.abbrev.editorialBoardMember');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (213, 37, 'en', 'name', 'Editorial Board Member');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (214, 37, 'en', 'abbrev', 'EBM');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (215, 37, 'id', 'name', 'Anggota Dewan Editor');
INSERT INTO public.user_group_settings (user_group_setting_id, user_group_id, locale, setting_name, setting_value) VALUES (216, 37, 'id', 'abbrev', 'EBM');


--
-- Data for Name: user_group_stage; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (1, 1, 3, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (2, 1, 3, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (3, 1, 3, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (4, 1, 3, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (5, 1, 4, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (6, 1, 4, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (7, 1, 5, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (8, 1, 5, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (9, 1, 5, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (10, 1, 5, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (11, 1, 6, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (12, 1, 6, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (13, 1, 6, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (14, 1, 6, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (15, 1, 7, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (16, 1, 8, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (17, 1, 9, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (18, 1, 9, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (19, 1, 10, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (20, 1, 11, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (21, 1, 12, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (22, 1, 13, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (23, 1, 14, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (24, 1, 14, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (25, 1, 14, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (26, 1, 14, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (28, 1, 15, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (29, 1, 15, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (30, 1, 15, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (31, 1, 16, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (32, 2, 21, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (33, 2, 21, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (34, 2, 21, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (35, 2, 21, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (36, 2, 22, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (37, 2, 22, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (38, 2, 23, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (39, 2, 23, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (40, 2, 23, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (41, 2, 23, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (42, 2, 24, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (43, 2, 24, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (44, 2, 24, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (45, 2, 24, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (46, 2, 25, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (47, 2, 26, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (48, 2, 27, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (49, 2, 27, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (50, 2, 28, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (51, 2, 29, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (52, 2, 30, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (53, 2, 31, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (54, 2, 32, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (55, 2, 32, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (56, 2, 32, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (57, 2, 32, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (58, 2, 33, 1);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (59, 2, 33, 3);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (60, 2, 33, 4);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (61, 2, 33, 5);
INSERT INTO public.user_group_stage (user_group_stage_id, context_id, user_group_id, stage_id) VALUES (62, 2, 34, 3);


--
-- Data for Name: user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (1, NULL, 1, 1, 1, 0, 0, 1, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (2, 1, 16, 1, 1, 0, 1, 1, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (3, 1, 16, 1, 1, 0, 1, 1, 1);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (4, 1, 16, 1, 1, 0, 1, 1, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (5, 1, 17, 1, 1, 0, 1, 0, 1);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (6, 1, 17, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (7, 1, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (8, 1, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (9, 1, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (10, 1, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (11, 1, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (12, 1, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (13, 1, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (14, 1, 65536, 1, 1, 1, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (15, 1, 65536, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (16, 1, 4096, 1, 1, 1, 0, 0, 1);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (17, 1, 1048576, 1, 1, 1, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (18, 1, 2097152, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (19, 1, 4097, 1, 1, 0, 0, 0, 1);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (20, 2, 16, 1, 1, 0, 1, 1, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (21, 2, 16, 1, 1, 0, 1, 1, 1);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (22, 2, 16, 1, 1, 0, 1, 1, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (23, 2, 17, 1, 1, 0, 1, 0, 1);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (24, 2, 17, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (25, 2, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (26, 2, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (27, 2, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (28, 2, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (29, 2, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (30, 2, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (31, 2, 4097, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (32, 2, 65536, 1, 1, 1, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (33, 2, 65536, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (34, 2, 4096, 1, 1, 1, 0, 0, 1);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (35, 2, 1048576, 1, 1, 1, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (36, 2, 2097152, 1, 1, 0, 0, 0, 0);
INSERT INTO public.user_groups (user_group_id, context_id, role_id, is_default, show_title, permit_self_registration, permit_metadata_edit, permit_settings, masthead) VALUES (37, 2, 4097, 1, 1, 0, 0, 0, 1);


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (1, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.metadata', 'dc11', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (2, 1, 0, 1, 0, '2026-07-23 09:10:04', 1, 'plugins.blocks', 'browse', 'BrowseBlockPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (3, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.blocks', 'developedBy', 'DevelopedByBlockPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (4, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.blocks', 'information', 'InformationBlockPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (5, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.blocks', 'languageToggle', 'LanguageToggleBlockPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (6, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.blocks', 'makeSubmission', 'MakeSubmissionBlockPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (7, 1, 1, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.blocks', 'subscription', 'SubscriptionBlockPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (8, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'announcementFeed', 'AnnouncementFeedPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (9, 0, 1, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'citationStyleLanguage', 'CitationStyleLanguagePlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (10, 1, 2, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'credit', 'CreditPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (11, 3, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'crossref', 'CrossrefPlugin', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (12, 1, 2, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'customBlockManager', 'CustomBlockManagerPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (13, 2, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'datacite', 'DatacitePlugin', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (14, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'driver', 'DRIVERPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (15, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'dublinCoreMeta', 'DublinCoreMetaPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (16, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'googleAnalytics', 'GoogleAnalyticsPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (17, 1, 1, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'googleScholar', 'GoogleScholarPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (18, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'htmlArticleGalley', 'HtmlArticleGalleyPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (19, 1, 0, 8, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'jatsTemplate', 'JatsTemplatePlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (20, 1, 0, 1, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'lensGalley', 'LensGalleyPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (21, 1, 0, 1, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'pdfJsViewer', 'PdfJsViewerPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (22, 1, 2, 1, 4, '2026-07-23 09:10:04', 1, 'plugins.generic', 'pflPlugin', 'PflPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (23, 1, 0, 0, 1, '2026-07-23 09:10:04', 1, 'plugins.generic', 'recommendByAuthor', 'RecommendByAuthorPlugin', 1, 1);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (24, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'recommendBySimilarity', 'RecommendBySimilarityPlugin', 1, 1);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (25, 1, 2, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'staticPages', 'StaticPagesPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (26, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'tinymce', 'TinyMCEPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (27, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'usageEvent', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (28, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.generic', 'webFeed', 'WebFeedPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (29, 1, 1, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.importexport', 'doaj', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (30, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.importexport', 'native', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (31, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.importexport', 'pubmed', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (32, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.importexport', 'users', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (33, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.oaiMetadataFormats', 'dc', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (34, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.oaiMetadataFormats', 'marc', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (35, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.oaiMetadataFormats', 'marcxml', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (36, 1, 0, 6, 1, '2026-07-23 09:10:04', 1, 'plugins.oaiMetadataFormats', 'oaiJats', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (37, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.oaiMetadataFormats', 'rfc1807', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (38, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.paymethod', 'manual', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (39, 1, 0, 0, 0, '2026-07-23 09:10:04', 1, 'plugins.paymethod', 'paypal', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (40, 1, 0, 0, 0, '2026-07-23 09:10:05', 1, 'plugins.pubIds', 'urn', 'URNPubIdPlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (41, 1, 0, 0, 0, '2026-07-23 09:10:05', 1, 'plugins.reports', 'articles', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (42, 1, 1, 0, 0, '2026-07-23 09:10:05', 1, 'plugins.reports', 'counterReport', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (43, 2, 0, 1, 0, '2026-07-23 09:10:05', 1, 'plugins.reports', 'reviewReport', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (44, 1, 0, 0, 0, '2026-07-23 09:10:05', 1, 'plugins.reports', 'subscriptions', '', 0, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (45, 1, 0, 0, 0, '2026-07-23 09:10:05', 1, 'plugins.themes', 'default', 'DefaultThemePlugin', 1, 0);
INSERT INTO public.versions (version_id, major, minor, revision, build, date_installed, current, product_type, product, product_class_name, lazy_load, sitewide) VALUES (46, 3, 5, 0, 5, '2026-07-23 09:09:47', 1, 'core', 'ojs2', '', 0, 1);


--
-- Name: email_templates_default_data_email_templates_default_data_i_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.email_templates_default_data_email_templates_default_data_i_seq', 148, true);


--
-- Name: email_templates_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.email_templates_email_id_seq', 12, true);


--
-- Name: filter_groups_filter_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.filter_groups_filter_group_id_seq', 27, true);


--
-- Name: filters_filter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.filters_filter_id_seq', 27, true);


--
-- Name: genre_settings_genre_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.genre_settings_genre_setting_id_seq', 24, true);


--
-- Name: genres_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.genres_genre_id_seq', 24, true);


--
-- Name: journal_settings_journal_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.journal_settings_journal_setting_id_seq', 140, true);


--
-- Name: journals_journal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.journals_journal_id_seq', 2, true);


--
-- Name: navigation_menu_item_assignme_navigation_menu_item_assignme_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.navigation_menu_item_assignme_navigation_menu_item_assignme_seq', 39, true);


--
-- Name: navigation_menu_item_settings_navigation_menu_item_setting__seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.navigation_menu_item_settings_navigation_menu_item_setting__seq', 41, true);


--
-- Name: navigation_menu_items_navigation_menu_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.navigation_menu_items_navigation_menu_item_id_seq', 41, true);


--
-- Name: navigation_menus_navigation_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.navigation_menus_navigation_menu_id_seq', 5, true);


--
-- Name: plugin_settings_plugin_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plugin_settings_plugin_setting_id_seq', 54, true);


--
-- Name: section_settings_section_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.section_settings_section_setting_id_seq', 6, true);


--
-- Name: sections_section_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sections_section_id_seq', 2, true);


--
-- Name: site_settings_site_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.site_settings_site_setting_id_seq', 15, true);


--
-- Name: site_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.site_site_id_seq', 1, true);


--
-- Name: user_group_settings_user_group_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_group_settings_user_group_setting_id_seq', 216, true);


--
-- Name: user_group_stage_user_group_stage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_group_stage_user_group_stage_id_seq', 62, true);


--
-- Name: user_groups_user_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_groups_user_group_id_seq', 37, true);


--
-- Name: versions_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.versions_version_id_seq', 46, true);


--
-- PostgreSQL database dump complete
--

\unrestrict raNERaNM2B5SNwG1fTB0g4DaW8zplT5gIZzVPiPvN2bo0AHig72ocSxRvRQWnNC

